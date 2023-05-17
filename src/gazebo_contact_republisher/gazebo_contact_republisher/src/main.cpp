#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/gazebo_client.hh>
#include <gazebo/gazebo_config.h>
#include <nav_msgs/Odometry.h>
#include <ros/ros.h>
#include <geometry_msgs/Vector3.h>
#include "gazebo_msgs/ContactState.h"
#include "gazebo_msgs/ContactsState.h"
#include <geometry_msgs/Vector3.h>
#include <iostream>
#include <vector>
ros::Publisher pub;

void contacts_callback(ConstContactsPtr &_msg){
    gazebo_msgs::ContactsState contacts;

    for (int i = 0; i < _msg->contact_size(); i++){
        gazebo_msgs::ContactState contact;

        contact.collision1_name = _msg->contact(i).collision1();
        contact.collision2_name = _msg->contact(i).collision2();

        for( int n = 0; n < _msg->contact(i).normal_size(); n++){
            geometry_msgs::Vector3 vector;

            vector.x = _msg->contact(i).normal().Get(n).x();
            vector.y = _msg->contact(i).normal().Get(n).y();
            vector.z = _msg->contact(i).normal().Get(n).z();

            contact.contact_normals.push_back(vector);
        }

        for( int p = 0; p < _msg->contact(i).position_size(); p++){
            geometry_msgs::Vector3 vector;

            vector.x = _msg->contact(i).position().Get(p).x();
            vector.y = _msg->contact(i).position().Get(p).y();
            vector.z = _msg->contact(i).position().Get(p).z();

            contact.contact_positions.push_back(vector);
        }

        for( int d = 0; d < _msg->contact(i).depth_size(); d++){
            contact.depths.push_back( _msg->contact(i).depth().Get(d) );
        }

        for( int w = 0; w < _msg->contact(i).wrench_size(); w++){
            geometry_msgs::Wrench wrench1;
            geometry_msgs::Wrench wrench2;

            wrench1.force.x = _msg->contact(i).wrench(w).body_1_wrench().force().x();
            wrench1.force.y = _msg->contact(i).wrench(w).body_1_wrench().force().y();
            wrench1.force.z = _msg->contact(i).wrench(w).body_1_wrench().force().z();

            wrench1.torque.x = _msg->contact(i).wrench(w).body_1_wrench().torque().x();
            wrench1.torque.y = _msg->contact(i).wrench(w).body_1_wrench().torque().y();
            wrench1.torque.z = _msg->contact(i).wrench(w).body_1_wrench().torque().z();

            wrench2.force.x = _msg->contact(i).wrench(w).body_2_wrench().force().x();
            wrench2.force.y = _msg->contact(i).wrench(w).body_2_wrench().force().y();
            wrench2.force.z = _msg->contact(i).wrench(w).body_2_wrench().force().z();

            wrench2.torque.x = _msg->contact(i).wrench(w).body_2_wrench().torque().x();
            wrench2.torque.y = _msg->contact(i).wrench(w).body_2_wrench().torque().y();
            wrench2.torque.z = _msg->contact(i).wrench(w).body_2_wrench().torque().z();

            contact.wrenches.push_back(wrench1);
            contact.wrenches.push_back(wrench2);
        }

        contacts.states.push_back(contact);
    }
    pub.publish(contacts);
}

int main(int _argc, char **_argv){
    // Load Gazebo & ROS
    gazebo::client::setup(_argc, _argv);
    ros::init(_argc, _argv, "binpacking_contacts");

    // Create Gazebo node and init
    gazebo::transport::NodePtr node(new gazebo::transport::Node());
    node->Init();

    // Create ROS node and init
    ros::NodeHandle n;
    pub = n.advertise<gazebo_msgs::ContactsState>("contacts", 1000);

    // Listen to Gazebo contacts topic
    gazebo::transport::SubscriberPtr sub = node->Subscribe("/gazebo/world/physics/contacts", contacts_callback);

    while (true){
        gazebo::common::Time::MSleep(20);
        ros::spinOnce();
    }
    gazebo::client::shutdown();
}