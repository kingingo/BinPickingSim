// Generated by gencpp from file contact_republisher/contacts_msg.msg
// DO NOT EDIT!


#ifndef CONTACT_REPUBLISHER_MESSAGE_CONTACTS_MSG_H
#define CONTACT_REPUBLISHER_MESSAGE_CONTACTS_MSG_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <contact_republisher/contact_msg.h>

namespace contact_republisher
{
template <class ContainerAllocator>
struct contacts_msg_
{
  typedef contacts_msg_<ContainerAllocator> Type;

  contacts_msg_()
    : contacts()  {
    }
  contacts_msg_(const ContainerAllocator& _alloc)
    : contacts(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector< ::contact_republisher::contact_msg_<ContainerAllocator> , typename std::allocator_traits<ContainerAllocator>::template rebind_alloc< ::contact_republisher::contact_msg_<ContainerAllocator> >> _contacts_type;
  _contacts_type contacts;





  typedef boost::shared_ptr< ::contact_republisher::contacts_msg_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::contact_republisher::contacts_msg_<ContainerAllocator> const> ConstPtr;

}; // struct contacts_msg_

typedef ::contact_republisher::contacts_msg_<std::allocator<void> > contacts_msg;

typedef boost::shared_ptr< ::contact_republisher::contacts_msg > contacts_msgPtr;
typedef boost::shared_ptr< ::contact_republisher::contacts_msg const> contacts_msgConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::contact_republisher::contacts_msg_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::contact_republisher::contacts_msg_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::contact_republisher::contacts_msg_<ContainerAllocator1> & lhs, const ::contact_republisher::contacts_msg_<ContainerAllocator2> & rhs)
{
  return lhs.contacts == rhs.contacts;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::contact_republisher::contacts_msg_<ContainerAllocator1> & lhs, const ::contact_republisher::contacts_msg_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace contact_republisher

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::contact_republisher::contacts_msg_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::contact_republisher::contacts_msg_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::contact_republisher::contacts_msg_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::contact_republisher::contacts_msg_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::contact_republisher::contacts_msg_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::contact_republisher::contacts_msg_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::contact_republisher::contacts_msg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "86961c1410790d81e56871bf92da4561";
  }

  static const char* value(const ::contact_republisher::contacts_msg_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x86961c1410790d81ULL;
  static const uint64_t static_value2 = 0xe56871bf92da4561ULL;
};

template<class ContainerAllocator>
struct DataType< ::contact_republisher::contacts_msg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "contact_republisher/contacts_msg";
  }

  static const char* value(const ::contact_republisher::contacts_msg_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::contact_republisher::contacts_msg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "contact_msg[] contacts\n"
"================================================================================\n"
"MSG: contact_republisher/contact_msg\n"
"string collision_1\n"
"string collision_2\n"
"float32[3] normal\n"
"float32[3] position\n"
"float32 depth\n"
;
  }

  static const char* value(const ::contact_republisher::contacts_msg_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::contact_republisher::contacts_msg_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.contacts);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct contacts_msg_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::contact_republisher::contacts_msg_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::contact_republisher::contacts_msg_<ContainerAllocator>& v)
  {
    s << indent << "contacts[]" << std::endl;
    for (size_t i = 0; i < v.contacts.size(); ++i)
    {
      s << indent << "  contacts[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::contact_republisher::contact_msg_<ContainerAllocator> >::stream(s, indent + "    ", v.contacts[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // CONTACT_REPUBLISHER_MESSAGE_CONTACTS_MSG_H
