# bio_ik_test

Trying to recreate this error in a simple environment with a basic ol' node:

https://github.com/PickNikRobotics/bio_ik/issues/7

## To recreate

```
$ ./build.sh
$ ./run.sh
$ gdb /bio_ik_test/install/bio_ik_test/lib/bio_ik_test/bio_ik_test
```

Full stack trace with debug symbls:

```
(gdb) bt
#0  __pthread_kill_implementation (threadid=281473777979424, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
#1  0x0000ffffb879f254 in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
#2  0x0000ffffb875a67c in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x0000ffffb8747130 in __GI_abort () at ./stdlib/abort.c:79
#4  0x0000ffffb80fc664 in _Unwind_SetGR () from /lib/aarch64-linux-gnu/libgcc_s.so.1
#5  0x0000ffffb8100adc in __gcc_personality_v0 () from /lib/aarch64-linux-gnu/libgcc_s.so.1
#6  0x0000ffffb8cbd8ec in _Unwind_RaiseException_Phase2 () from /bio_ik_test/install/bio_ik/lib/libbio_ik.so
#7  0x0000ffffb8cbde48 in _Unwind_RaiseException () from /bio_ik_test/install/bio_ik/lib/libbio_ik.so
#8  0x0000ffffb8c16c08 in __cxa_throw () from /bio_ik_test/install/bio_ik/lib/libbio_ik.so
#9  0x0000ffffb6013dbc in boost::interprocess::shared_memory_object::priv_open_or_create (perm=..., mode=boost::interprocess::read_write, filename=<optimized out>, 
    type=boost::interprocess::ipcdetail::DoOpen, this=0xfffff6485088) at ./thirdparty/boost/include/boost/interprocess/shared_memory_object.hpp:363
#10 boost::interprocess::shared_memory_object::shared_memory_object(boost::interprocess::open_only_t, char const*, boost::interprocess::mode_t) [clone .constprop.0] (
    this=0xfffff6485088, name=<optimized out>, mode=boost::interprocess::read_write) at ./thirdparty/boost/include/boost/interprocess/shared_memory_object.hpp:83
#11 0x0000ffffb601059c in boost::interprocess::ipcdetail::managed_open_or_create_impl<boost::interprocess::shared_memory_object, 16ul, true, false>::priv_open_or_create<boost::interprocess::ipcdetail::create_open_func<boost::interprocess::ipcdetail::basic_managed_memory_impl<char, boost::interprocess::rbtree_best_fit<boost::interprocess::mutex_family, boost::interprocess::offset_ptr<void, unsigned int, unsigned long, 0ul>, 0ul>, boost::interprocess::iset_index, 16ul> > >(boost::interprocess::ipcdetail::create_enum_t, char const* const&, unsigned long, boost::interprocess::mode_t, void const*, boost::interprocess::permissions const&, boost::interprocess::ipcdetail::create_open_func<boost::interprocess::ipcdetail::basic_managed_memory_impl<char, boost::interprocess::rbtree_best_fit<boost::interprocess::mutex_family, boost::interprocess::offset_ptr<void, unsigned int, unsigned long, 0ul>, 0ul>, boost::interprocess::iset_index, 16ul> >) [clone .constprop.0] (this=this@entry=0xaaaaf6d4f4f8, 
    type=type@entry=boost::interprocess::ipcdetail::DoOpen, id=@0xfffff6485160: 0xaaaaf6d4f520 "fastrtps_port7661", size=size@entry=0, 
    mode=mode@entry=boost::interprocess::read_write, perm=..., construct_func=..., addr=0x0)
    at ./thirdparty/boost/include/boost/interprocess/detail/managed_open_or_create_impl.hpp:339
#12 0x0000ffffb600e2d4 in boost::interprocess::ipcdetail::managed_open_or_create_impl<boost::interprocess::shared_memory_object, 16ul, true, false>::managed_open_or_create_impl<boost::interprocess::ipcdetail::create_open_func<boost::interprocess::ipcdetail::basic_managed_memory_impl<char, boost::interprocess::rbtree_best_fit<boost::interprocess::mutex_family, boost::interprocess::offset_ptr<void, unsigned int, unsigned long, 0ul>, 0ul>, boost::interprocess::iset_index, 16ul> > > (construct_func=..., construct_func=..., addr=0x0, mode=boost::interprocess::read_write, id=@0xfffff6485160: 0xaaaaf6d4f520 "fastrtps_port7661", this=0xaaaaf6d4f4f8) at ./thirdparty/boost/include/boost/interprocess/detail/managed_open_or_create_impl.hpp:202
#13 boost::interprocess::basic_managed_shared_memory<char, boost::interprocess::rbtree_best_fit<boost::interprocess::mutex_family, boost::interprocess::offset_ptr<void, unsigned int, unsigned long, 0ul>, 0ul>, boost::interprocess::iset_index>::basic_managed_shared_memory (addr=0x0, name=<optimized out>, this=0xaaaaf6d4f4f0) at ./thirdparty/boost/include/boost/interprocess/managed_shared_memory.hpp:151
#14 eprosima::fastdds::rtps::SharedSegment<boost::interprocess::basic_managed_shared_memory<char, boost::interprocess::rbtree_best_fit<boost::interprocess::mutex_family, boost::interprocess::offset_ptr<void, unsigned int, unsigned long, 0ul>, 0ul>, boost::interprocess::iset_index>, boost::interprocess::shared_memory_object>::SharedSegment(boost::interprocess::open_only_t, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) [clone .constprop.0] (this=0xaaaaf6d2ee80, name=...) at ./src/cpp/utils/shared_memory/SharedMemSegment.hpp:272
#15 0x0000ffffb5eda1c0 in eprosima::fastdds::rtps::SharedMemGlobal::open_port_internal (this=0xaaaaf6d2aa88, port_id=7661, max_buffer_descriptors=512, healthy_check_timeout_ms=1000, open_mode=eprosima::fastdds::rtps::SharedMemGlobal::Port::OpenMode::ReadExclusive, regenerating_port=...) at ./src/cpp/rtps/transport/shared_mem/SharedMemGlobal.hpp:1078
#16 0x0000ffffb5ee73d8 in eprosima::fastdds::rtps::SharedMemGlobal::open_port (open_mode=eprosima::fastdds::rtps::SharedMemGlobal::Port::OpenMode::ReadExclusive, healthy_check_timeout_ms=<optimized out>, max_buffer_descriptors=<optimized out>, port_id=<optimized out>, this=0xaaaaf6d2aa88) at ./src/cpp/rtps/transport/shared_mem/SharedMemGlobal.hpp:991
#17 eprosima::fastdds::rtps::SharedMemManager::open_port (open_mode=eprosima::fastdds::rtps::SharedMemGlobal::Port::OpenMode::ReadExclusive, healthy_check_timeout_ms=<optimized out>, max_descriptors=<optimized out>, port_id=<optimized out>, this=0xaaaaf6d2aa00) at ./src/cpp/rtps/transport/shared_mem/SharedMemManager.hpp:1008
#18 eprosima::fastdds::rtps::SharedMemTransport::CreateInputChannelResource (this=0xaaaaf6d2a6f0, locator=..., maxMsgSize=<optimized out>, receiver=0xaaaaf6d4f350) at ./src/cpp/rtps/transport/shared_mem/SharedMemTransport.cpp:319
#19 0x0000ffffb5ede63c in eprosima::fastdds::rtps::SharedMemTransport::OpenInputChannel (this=0xaaaaf6d2a6f0, locator=..., receiver=0xaaaaf6d4f350, maxMsgSize=4294967295) at ./src/cpp/rtps/transport/shared_mem/SharedMemTransport.cpp:134
#20 0x0000ffffb5cca9e0 in eprosima::fastrtps::rtps::ReceiverResource::ReceiverResource (this=<optimized out>, transport=..., locator=..., max_recv_buffer_size=<optimized out>, this=<optimized out>, transport=..., locator=..., max_recv_buffer_size=<optimized out>) at ./src/cpp/rtps/network/ReceiverResource.cpp:41
#21 0x0000ffffb5ccac04 in eprosima::fastrtps::rtps::NetworkFactory::BuildReceiverResources (this=<optimized out>, local=..., returned_resources_list=std::vector of length 0, capacity 0, receiver_max_message_size=4294967295) at /usr/include/c++/11/bits/unique_ptr.h:173
#22 0x0000ffffb5cd594c in eprosima::fastrtps::rtps::RTPSParticipantImpl::createReceiverResources (this=0xaaaaf6d25510, Locator_list=..., ApplyMutation=true, RegisterReceiver=false, log_when_creation_fails=true) at ./src/cpp/rtps/participant/RTPSParticipantImpl.cpp:1651
#23 0x0000ffffb5ccf818 in eprosima::fastrtps::rtps::RTPSParticipantImpl::RTPSParticipantImpl (this=<optimized out>, domain_id=<optimized out>, PParam=..., guidP=..., persistence_guid=..., par=<optimized out>, plisten=<optimized out>, this=<optimized out>, domain_id=<optimized out>, PParam=..., guidP=..., persistence_guid=..., par=<optimized out>, plisten=<optimized out>) at ./src/cpp/rtps/participant/RTPSParticipantImpl.cpp:364
#24 0x0000ffffb5cdf378 in eprosima::fastrtps::rtps::RTPSDomain::createParticipant (domain_id=1, enabled=<optimized out>, attrs=..., listen=0xaaaaf6d24948) at ./src/cpp/rtps/RTPSDomain.cpp:167
#25 0x0000ffffb5d32940 in eprosima::fastdds::dds::DomainParticipantImpl::enable (this=0xaaaaf6d23da0) at ./src/cpp/fastdds/domain/DomainParticipantImpl.cpp:304
#26 0x0000ffffb5d34aac in eprosima::fastdds::dds::DomainParticipant::enable (this=0xaaaaf6d23cf0) at ./src/cpp/fastdds/domain/DomainParticipant.cpp:95
#27 eprosima::fastdds::dds::DomainParticipant::enable (this=0xaaaaf6d23cf0) at ./src/cpp/fastdds/domain/DomainParticipant.cpp:87
#28 eprosima::fastdds::dds::DomainParticipantFactory::create_participant (this=0xffffb6178368 <eprosima::fastdds::dds::DomainParticipantFactory::get_instance()::instance>, did=did@entry=1, qos=..., listen=<optimized out>, mask=...) at ./src/cpp/fastdds/domain/DomainParticipantFactory.cpp:249
#29 0x0000ffffb6211634 in __create_participant (identifier=0xffffb629dcd8 "rmw_fastrtps_cpp", domainParticipantQos=..., leave_middleware_default_qos=false, publishing_mode=publishing_mode_t::SYNCHRONOUS, common_context=0xaaaaf6d22ad0, domain_id=1) at ./src/participant.cpp:100
#30 0x0000ffffb621d908 in rmw_fastrtps_shared_cpp::create_participant (identifier=0xffffb629dcd8 "rmw_fastrtps_cpp", domain_id=1, security_options=<optimized out>, localhost_only=<optimized out>, enclave=<optimized out>, common_context=0xaaaaf6d22ad0) at ./src/participant.cpp:284
#31 0x0000ffffb6289148 in ?? () from /opt/ros/humble/lib/librmw_fastrtps_cpp.so
#32 0x0000ffffb6290c88 in rmw_create_node () from /opt/ros/humble/lib/librmw_fastrtps_cpp.so
#33 0x0000ffffb84b0f5c in rcl_node_init () from /opt/ros/humble/lib/librcl.so
#34 0x0000ffffb89ec4c4 in rclcpp::node_interfaces::NodeBase::NodeBase(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::shared_ptr<rclcpp::Context>, rcl_node_options_s const&, bool, bool) () from /opt/ros/humble/lib/librclcpp.so
#35 0x0000ffffb89e4028 in rclcpp::Node::Node(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rclcpp::NodeOptions const&) () from /opt/ros/humble/lib/librclcpp.so
#36 0x0000ffffb89e5088 in rclcpp::Node::Node(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rclcpp::NodeOptions const&) () from /opt/ros/humble/lib/librclcpp.so
#37 0x0000aaaadd493320 in __gnu_cxx::new_allocator<rclcpp::Node>::construct<rclcpp::Node, char const (&) [12], rclcpp::NodeOptions&> (this=<optimized out>, __p=0xaaaaf6d221a0) at /usr/include/c++/11/ext/new_allocator.h:162
#38 std::allocator_traits<std::allocator<rclcpp::Node> >::construct<rclcpp::Node, char const (&) [12], rclcpp::NodeOptions&> (__p=0xaaaaf6d221a0, __a=...) at /usr/include/c++/11/bits/alloc_traits.h:516
#39 std::_Sp_counted_ptr_inplace<rclcpp::Node, std::allocator<rclcpp::Node>, (__gnu_cxx::_Lock_policy)2>::_Sp_counted_ptr_inplace<char const (&) [12], rclcpp::NodeOptions&> (__a=..., this=0xaaaaf6d22190) at /usr/include/c++/11/bits/shared_ptr_base.h:519
#40 std::__shared_count<(__gnu_cxx::_Lock_policy)2>::__shared_count<rclcpp::Node, std::allocator<rclcpp::Node>, char const (&) [12], rclcpp::NodeOptions&> (__a=..., __p=@0xfffff648d920: 0x0, this=0xfffff648d928) at /usr/include/c++/11/bits/shared_ptr_base.h:650
#41 std::__shared_ptr<rclcpp::Node, (__gnu_cxx::_Lock_policy)2>::__shared_ptr<std::allocator<rclcpp::Node>, char const (&) [12], rclcpp::NodeOptions&> (this=this@entry=0xfffff648d920, __tag=..., __tag@entry=...) at /usr/include/c++/11/bits/shared_ptr_base.h:1342
#42 0x0000aaaadd4935a0 in std::shared_ptr<rclcpp::Node>::shared_ptr<std::allocator<rclcpp::Node>, char const (&) [12], rclcpp::NodeOptions&> (__tag=..., this=0xfffff648d920) at /usr/include/c++/11/bits/shared_ptr.h:409
#43 std::allocate_shared<rclcpp::Node, std::allocator<rclcpp::Node>, char const (&) [12], rclcpp::NodeOptions&> (__a=...) at /usr/include/c++/11/bits/shared_ptr.h:863
#44 std::make_shared<rclcpp::Node, char const (&) [12], rclcpp::NodeOptions&> () at /usr/include/c++/11/bits/shared_ptr.h:879
#45 rclcpp::Node::make_shared<char const (&) [12], rclcpp::NodeOptions&> () at /opt/ros/humble/include/rclcpp/rclcpp/node.hpp:80
#46 main (argc=1, argv=0xfffff648ddb8) at /bio_ik_test/src/bio_ik_test/src/test.cpp:10
```
