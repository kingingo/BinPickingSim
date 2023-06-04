#include <iostream>
#include <math.h>
#include <gazebo/common/Plugin.hh>
#include <boost/shared_ptr.hpp>
#include <ros/ros.h>
#include <gazebo/gazebo.hh>
#include "gazebo/common/common.hh"
#include "gazebo/msgs/msgs.hh"
#include "gazebo/physics/physics.hh"
#include "gazebo/transport/transport.hh"
#include <gazebo/rendering/DynamicLines.hh>
#include "gazebo/rendering/RenderTypes.hh"
#include "gazebo/rendering/Visual.hh"
#include "gazebo/rendering/Scene.hh"
#include <gazebo/rendering/rendering.hh>
#include <ignition/transport/Node.hh>
#include "gz_ray_label_plugin/LabelPoint.h"
#include "gz_ray_label_plugin/LabelPoints.h"
#include <visualization_msgs/Marker.h>
#include <sstream>
#define MAKE_STRING(tokens) /****************/ \
    static_cast<std::ostringstream&>(          \
        std::ostringstream().flush() << tokens \
    ).str()


namespace gazebo
{

class GZRayLabelPlugin : public WorldPlugin
{
    private: transport::NodePtr node;
    private: physics::WorldPtr world;
    private: ros::Subscriber subscriber;
    private: ros::NodeHandle nh;
    private: ros::Publisher publisher;
    private: ros::Publisher marker_publisher;


    public: GZRayLabelPlugin() : WorldPlugin(){
    }

    public: void Load(physics::WorldPtr _parent, sdf::ElementPtr _sdf){
        if (!ros::isInitialized()){
            int argc = 0;
            char **argv = NULL;
            ros::init(argc, argv, "gazebo_client", ros::init_options::NoSigintHandler);
        }

        node = transport::NodePtr(new transport::Node());
        world = _parent;

        #if GAZEBO_MAJOR_VERSION >= 8
            node->Init(world->Name());
        #else
            node->Init(world->GetName());
        #endif

        subscriber = nh.subscribe("/ray/points", 10, &GZRayLabelPlugin::onSubscribe, this);
        publisher = nh.advertise<gz_ray_label_plugin::LabelPoints>("/ray/labeled/points", 10);
        marker_publisher = nh.advertise<visualization_msgs::Marker>("visualization_marker", 1);

        log("Ray label plugin has been loaded");
    }

    public: void log(const std::string msg){
        std::cout << "[gz-ray] "  << msg.c_str() << std::endl;
    }

    public: void onSubscribe(const gz_ray_label_plugin::LabelPoints& data){
        log("got a message :)");
        std::string not_found = "None";
        double dist;
        std::string entityName;
        gz_ray_label_plugin::LabelPoints _data;
        //gz_ray_label_plugin::LabelPoints again;
        gz_ray_label_plugin::LabelPoint _point;
        //boost::shared_ptr<gz_ray_label_plugin::LabelPoints> dataPtr;
        //boost::shared_ptr<gz_ray_label_plugin::LabelPoints> againPtr;
        boost::shared_ptr<gz_ray_label_plugin::LabelPoints> ptr;
        gazebo::physics::RayShapePtr ray;
        gazebo::physics::PhysicsEnginePtr engine;
        ignition::math::Vector3d start, end, scale;

        geometry_msgs::Point line_end, line_start;
        /* RVIZ Ray visualization */
        visualization_msgs::Marker line;
        if(data.showMarker){
            line.type = visualization_msgs::Marker::LINE_STRIP;
            line.header.frame_id = "map";
            line.ns = "ray_ns";
            line.action = visualization_msgs::Marker::ADD;
            line.pose.orientation.w = 1.0;
            line.id = 0;
            line.scale.x = 0.01;
            line.scale.y = 0.01;
            line.scale.z = 0.01;
            //color red
            line.color.r = 1.0;
            line.color.a = 1.0;
        }

        #if GAZEBO_MAJOR_VERSION >= 8
            engine = world->Physics();
        #else
            engine = world->GetPhysicsEngine();
        #endif
        engine->InitForThread();
        ray = boost::dynamic_pointer_cast<gazebo::physics::RayShape>( 
                engine->CreateShape("ray", gazebo::physics::CollisionPtr())
            );

        int length = data.points.size();
        _data.points.reserve(length);
        log(MAKE_STRING("points length:" << length));
        
        int c = 1;
        int f = 0;
        int d = 0;
        ros::Rate r(data.rate);
        length = data.points.size();
        d = length / 100;
        c = 1;
        engine->Reset();
        for(auto it = data.points.begin(); it != data.points.end(); it++){
            if(c % d == 0){
                log(MAKE_STRING("found " << f << " Percent completed "  << ceil(c * 100.0 / length) << "%"));
            }
            _point.x = it->x;
            _point.y = it->y;
            _point.z = it->z;
            _point.index = it->index;

            scale.X(0);
            scale.Y(0);
            scale.Z(it->z - data.start_z);

            /*
            start.X(scale.X() * scaling);
            start.Y(scale.Y() * scaling);
            start.Z(start_z + scale.Z() * scaling);
            */

            start.X(it->x);
            start.Y(it->y);
            start.Z(data.start_z);

            end.X(it->x + scale.X() * data.scaling);
            end.Y(it->y + scale.Y() * data.scaling);
            end.Z(it->z + scale.Z() * data.scaling);

            if(data.showMarker){
                line_start.x = it->x;
                line_start.y = it->y;
                line_start.z = data.start_z;

                line_end.x = it->x + scale.X() * data.scaling;
                line_end.y = it->y + scale.Y() * data.scaling;
                line_end.z = it->z + scale.Z() * data.scaling;
                
                line.points.clear();
                line.points.push_back(line_start);
                line.points.push_back(line_end);
            }
            
            ray->SetPoints(start, end);
            ray->GetIntersection(dist, entityName);

            if (!entityName.empty()){
                f++;
                _point.dist = dist;
                _point.entityName = entityName;
            }else{
                _point.entityName = not_found;
            }
            _data.points.push_back(_point);
            c++;
            if(data.showMarker){
                marker_publisher.publish(line);
                r.sleep();
            }
        }
        log(MAKE_STRING("done scanning total found " << f));
        publisher.publish(_data);
        /*
        dataPtr = boost::make_shared<gz_ray_label_plugin::LabelPoints>(data);
        againPtr = boost::make_shared<gz_ray_label_plugin::LabelPoints>(again);
        for(int i = 0; i < 100; i++){
            
            if(i > 0){
                if( i % 2 == 0){
                    ptr = dataPtr;
                    dataPtr = againPtr;
                    againPtr = ptr;
                }else{
                    ptr = againPtr;
                    againPtr = dataPtr;
                    dataPtr = ptr;
                }
            }

            againPtr->points.clear();
            length = dataPtr->points.size();
            std::cout << "start " << (i+1) << ". Epoche end data size " << dataPtr->points.size() << " again: "  << againPtr->points.size() << std::endl;

            if(length <= 0){
                std::cout << "data empty done :)" << std::endl;
                break;
            }

            d = length / 100;
            c = 1;
            engine->Reset();
            for(auto it = dataPtr->points.begin(); it != dataPtr->points.end(); it++){
                if(c % d == 0){
                    std::cout << (i+1) << ". Epoche total found " << f << " Percent completed "  << ceil(c * 100.0 / length) << "%" << std::endl;
                }
                _point.x = it->x;
                _point.y = it->y;
                _point.z = it->z;
                _point.index = it->index;

                scale.X(it->x);
                scale.Y(it->y);
                scale.Z(it->z - start_z);

                /*
                start.X(scale.X() * scaling);
                start.Y(scale.Y() * scaling);
                start.Z(start_z + scale.Z() * scaling);
                */
                /*
                start.X(it->x);
                start.Y(it->y);
                start.Z(start_z);

                end.X(it->x);
                end.Y(it->y);
                end.Z(0);
                /*
                line_start.x = scale.X() * scaling;
                line_start.y = scale.Y() * scaling;
                line_start.z = start_z + scale.Z() * scaling;
                */
               /*
               line_start.x = it->x;
               line_start.y = it->y;
               line_start.z = start_z;

                line_end.x = it->x;
                line_end.y = it->y;
                line_end.z = 0;
                
                line.points.clear();
                line.points.push_back(line_start);
                line.points.push_back(line_end);
                
                ray->SetPoints(start, end);
                ray->GetIntersection(dist, entityName);

                if (!entityName.empty()){
                    f++;
                    _point.dist = dist;
                    _point.entityName = entityName;
                    _data.points.push_back(_point);
                }else{
                    againPtr->points.push_back(_point);
                }
                marker_publisher.publish(line);
                c++;
                //r.sleep();
            }
            std::cout << (i+1) << ". Epoche end size:" << againPtr->points.size() << " total found:" << f << std::endl;
            //end_z += 0.001;       
        }
        */
    }
};

GZ_REGISTER_WORLD_PLUGIN(GZRayLabelPlugin)
}