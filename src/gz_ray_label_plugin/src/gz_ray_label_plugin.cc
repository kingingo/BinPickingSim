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
#include "gz_ray_label_plugin/LabelPoint.h"
#include "gz_ray_label_plugin/LabelPoints.h"

namespace gazebo
{

class GZRayLabelPlugin : public WorldPlugin
{
    private: transport::NodePtr node;
    private: physics::WorldPtr world;
    private: ros::Subscriber subscriber;
    private: ros::NodeHandle nh;
    private: ros::Publisher publisher;


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

        std::cout << "Ray label plugin has been loaded" << std::endl;
    }

    public: void onSubscribe(const gz_ray_label_plugin::LabelPoints& data){
        std::cout << "got a message :)" << std::endl;
        std::string not_found = "None";
        double dist;
        std::string entityName;
        gz_ray_label_plugin::LabelPoints _data;
        gz_ray_label_plugin::LabelPoint _point;
        ignition::math::Vector3d start, end, scale;

        #if GAZEBO_MAJOR_VERSION >= 8
            gazebo::physics::PhysicsEnginePtr engine = world->Physics();
        #else
            gazebo::physics::PhysicsEnginePtr engine = world->GetPhysicsEngine();
        #endif
        engine->InitForThread();
        gazebo::physics::RayShapePtr ray = boost::dynamic_pointer_cast<gazebo::physics::RayShape>( 
                engine->CreateShape("ray", gazebo::physics::CollisionPtr())
            );
        //gazebo::physics::VisualPtr visual = _world->GetModel("ray_model")->GetVisual("ray_visual");
        int length = data.points.size();
        _data.points.reserve(length);
        std::cout << "points length:" << length << std::endl;

        start.X(0);
        start.Y(0);
        start.Z(1.9);
        
        int c = 1;
        int f = 0;
        int d = length / 10;
        for(auto it = data.points.begin(); it != data.points.end(); it++){
            if(c % d == 0){
                std::cout << "found " << f << " Percent completed "  << ceil(c * 100.0 / length) << "%" << std::endl;
            }

            _point.x = it->x;
            _point.y = it->y;
            _point.z = it->z;
            _point.index = it->index;

            end.X(it->x);
            end.Y(it->y);
            end.Z(it->z);
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
        }
        publisher.publish(_data);
    }
};

GZ_REGISTER_WORLD_PLUGIN(GZRayLabelPlugin)
}