#include <rclcpp/rclcpp.hpp>


int main(int argc, char** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::NodeOptions node_options;

  node_options.automatically_declare_parameters_from_overrides(true);
  auto node = rclcpp::Node::make_shared("test_bio_ik", node_options);

  rclcpp::shutdown();
  return 0;
}
