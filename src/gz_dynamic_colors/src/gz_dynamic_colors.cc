// GAZEBO
#include <gazebo/common/Plugin.hh>
#include <gazebo/rendering/rendering.hh>
#include <ignition/math/Color.hh>
#include <gazebo/gazebo.hh>

// THREAD
#include <string>
#include <boost/thread.hpp>
#include <boost/thread/mutex.hpp>
#include <boost/bind.hpp>

// ROS
#include <ros/ros.h>
#include <gazebo_msgs/SetLightProperties.h>
#include <ros/callback_queue.h>
#include <ros/advertise_options.h>
#include <std_msgs/ColorRGBA.h>
#include "gz_dynamic_colors/DColor.h"
#include "gazebo/common/common.hh"
#include "gazebo/msgs/msgs.hh"

#define MAKE_STRING(tokens) /****************/ \
    static_cast<std::ostringstream&>(          \
        std::ostringstream().flush() << tokens \
    ).str()

namespace gazebo
{

class GZColorPlugin : public VisualPlugin
{
    /*
    private: transport::NodePtr node;
    private: ros::Subscriber subscriber;
    private: ros::NodeHandle nh;
    private: std::string service_name_;
    private: std::string robot_namespace_;
    private: rendering::VisualPtr model_;
    private: sdf::ElementPtr sdf_;
    */

    public: GZColorPlugin() : VisualPlugin(){
    }

    public: void Load(rendering::VisualPtr _visual, sdf::ElementPtr _sdf){
        /*
        if (!ros::isInitialized()){
            int argc = 0;
            char **argv = NULL;
            ros::init(argc, argv, "gazebo_client", ros::init_options::NoSigintHandler);
        }
        */
        if (_sdf->HasElement("color")){
            ignition::math::Color default_color = _sdf->Get<ignition::math::Color>("color");
            _visual->SetAmbient(default_color);
            _visual->SetDiffuse(default_color);
        }

        /*
        this->service_name_ = "/model_color";
        if (this->sdf_->HasElement("serviceName")) {
            this->service_name_ = this->sdf_->Get<std::string>("serviceName");
        }

        node = transport::NodePtr(new transport::Node());

        #if GAZEBO_MAJOR_VERSION >= 8
            node->Init("map");
        #else
            node->Init("map");
        #endif

        subscriber = nh.subscribe(this->service_name_, 10, &GZColorPlugin::onSubscribe, this);

        log("Ray label plugin has been loaded");
        */
    }
    /*
    public: void log(const std::string msg){
        std::cout << "\033[32m[gz-ray] " << msg.c_str() << "\033[0m" << std::endl;
    }

    public: void onSubscribe(const gz_dynamic_colors::DColor& data){
        log(MAKE_STRING("got colors: " << data.r << "/" << data.g << "/" << data.b));
    }
    */
};
GZ_REGISTER_VISUAL_PLUGIN(GZColorPlugin)
}