// Generated by gencpp from file gz_ray_label_plugin/LabelPoints.msg
// DO NOT EDIT!


#ifndef GZ_RAY_LABEL_PLUGIN_MESSAGE_LABELPOINTS_H
#define GZ_RAY_LABEL_PLUGIN_MESSAGE_LABELPOINTS_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <gz_ray_label_plugin/LabelPoint.h>

namespace gz_ray_label_plugin
{
template <class ContainerAllocator>
struct LabelPoints_
{
  typedef LabelPoints_<ContainerAllocator> Type;

  LabelPoints_()
    : points()  {
    }
  LabelPoints_(const ContainerAllocator& _alloc)
    : points(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector< ::gz_ray_label_plugin::LabelPoint_<ContainerAllocator> , typename std::allocator_traits<ContainerAllocator>::template rebind_alloc< ::gz_ray_label_plugin::LabelPoint_<ContainerAllocator> >> _points_type;
  _points_type points;



// reducing the odds to have name collisions with Windows.h 
#if defined(_WIN32) && defined(scaling)
  #undef scaling
#endif
#if defined(_WIN32) && defined(start_z)
  #undef start_z
#endif
#if defined(_WIN32) && defined(rating)
  #undef rating
#endif
#if defined(_WIN32) && defined(showMarker)
  #undef showMarker
#endif

  enum {
    rating = 800,
  };

  static const float scaling;
  static const float start_z;
  static const uint8_t showMarker;

  typedef boost::shared_ptr< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> const> ConstPtr;

}; // struct LabelPoints_

typedef ::gz_ray_label_plugin::LabelPoints_<std::allocator<void> > LabelPoints;

typedef boost::shared_ptr< ::gz_ray_label_plugin::LabelPoints > LabelPointsPtr;
typedef boost::shared_ptr< ::gz_ray_label_plugin::LabelPoints const> LabelPointsConstPtr;

// constants requiring out of line definition

   
   template<typename ContainerAllocator> const float
      LabelPoints_<ContainerAllocator>::scaling =
        
          0.15
        
        ;
   

   
   template<typename ContainerAllocator> const float
      LabelPoints_<ContainerAllocator>::start_z =
        
          0.5
        
        ;
   

   

   
   template<typename ContainerAllocator> const uint8_t
      LabelPoints_<ContainerAllocator>::showMarker =
        
           0
        
        ;
   



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator1> & lhs, const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator2> & rhs)
{
  return lhs.points == rhs.points;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator1> & lhs, const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace gz_ray_label_plugin

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >
{
  static const char* value()
  {
    return "8df55850541ba2b90a87120a4b1cc925";
  }

  static const char* value(const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x8df55850541ba2b9ULL;
  static const uint64_t static_value2 = 0x0a87120a4b1cc925ULL;
};

template<class ContainerAllocator>
struct DataType< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >
{
  static const char* value()
  {
    return "gz_ray_label_plugin/LabelPoints";
  }

  static const char* value(const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >
{
  static const char* value()
  {
    return "LabelPoint[] points\n"
"float32 scaling = 0.15\n"
"float32 start_z = 0.5\n"
"int32 rating = 800\n"
"bool showMarker = 0\n"
"================================================================================\n"
"MSG: gz_ray_label_plugin/LabelPoint\n"
"float32 x\n"
"float32 y\n"
"float32 z\n"
"int32 index\n"
"float64 dist\n"
"string entityName\n"
;
  }

  static const char* value(const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.points);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct LabelPoints_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::gz_ray_label_plugin::LabelPoints_<ContainerAllocator>& v)
  {
    s << indent << "points[]" << std::endl;
    for (size_t i = 0; i < v.points.size(); ++i)
    {
      s << indent << "  points[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::gz_ray_label_plugin::LabelPoint_<ContainerAllocator> >::stream(s, indent + "    ", v.points[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // GZ_RAY_LABEL_PLUGIN_MESSAGE_LABELPOINTS_H
