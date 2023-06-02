// Generated by gencpp from file binpacking/LabelPoints.msg
// DO NOT EDIT!


#ifndef BINPACKING_MESSAGE_LABELPOINTS_H
#define BINPACKING_MESSAGE_LABELPOINTS_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <binpacking/LabelPoint.h>

namespace binpacking
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



   typedef std::vector< ::binpacking::LabelPoint_<ContainerAllocator> , typename std::allocator_traits<ContainerAllocator>::template rebind_alloc< ::binpacking::LabelPoint_<ContainerAllocator> >> _points_type;
  _points_type points;





  typedef boost::shared_ptr< ::binpacking::LabelPoints_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::binpacking::LabelPoints_<ContainerAllocator> const> ConstPtr;

}; // struct LabelPoints_

typedef ::binpacking::LabelPoints_<std::allocator<void> > LabelPoints;

typedef boost::shared_ptr< ::binpacking::LabelPoints > LabelPointsPtr;
typedef boost::shared_ptr< ::binpacking::LabelPoints const> LabelPointsConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::binpacking::LabelPoints_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::binpacking::LabelPoints_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::binpacking::LabelPoints_<ContainerAllocator1> & lhs, const ::binpacking::LabelPoints_<ContainerAllocator2> & rhs)
{
  return lhs.points == rhs.points;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::binpacking::LabelPoints_<ContainerAllocator1> & lhs, const ::binpacking::LabelPoints_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace binpacking

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::binpacking::LabelPoints_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::binpacking::LabelPoints_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::binpacking::LabelPoints_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::binpacking::LabelPoints_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::binpacking::LabelPoints_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::binpacking::LabelPoints_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::binpacking::LabelPoints_<ContainerAllocator> >
{
  static const char* value()
  {
    return "a2a82d81b27b9b480fb075f2d96f64cd";
  }

  static const char* value(const ::binpacking::LabelPoints_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xa2a82d81b27b9b48ULL;
  static const uint64_t static_value2 = 0x0fb075f2d96f64cdULL;
};

template<class ContainerAllocator>
struct DataType< ::binpacking::LabelPoints_<ContainerAllocator> >
{
  static const char* value()
  {
    return "binpacking/LabelPoints";
  }

  static const char* value(const ::binpacking::LabelPoints_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::binpacking::LabelPoints_<ContainerAllocator> >
{
  static const char* value()
  {
    return "LabelPoint[] points\n"
"================================================================================\n"
"MSG: binpacking/LabelPoint\n"
"float32 x\n"
"float32 y\n"
"float32 z\n"
"string entityName\n"
;
  }

  static const char* value(const ::binpacking::LabelPoints_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::binpacking::LabelPoints_<ContainerAllocator> >
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
struct Printer< ::binpacking::LabelPoints_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::binpacking::LabelPoints_<ContainerAllocator>& v)
  {
    s << indent << "points[]" << std::endl;
    for (size_t i = 0; i < v.points.size(); ++i)
    {
      s << indent << "  points[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::binpacking::LabelPoint_<ContainerAllocator> >::stream(s, indent + "    ", v.points[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // BINPACKING_MESSAGE_LABELPOINTS_H
