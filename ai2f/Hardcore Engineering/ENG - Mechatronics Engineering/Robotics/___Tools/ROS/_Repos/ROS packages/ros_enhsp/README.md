# ros_enhsp
ROS wrapper for the Expressive Numerical Heuristic Search Planner (ENHSP). Part of project published as "[Energy-Aware Path Planning for Autonomous Mobile Robot Navigation](https://www.aaai.org/ocs/index.php/FLAIRS/FLAIRS20/paper/viewPaper/18463)".

## Description

This package integrates the [ENHSP planner](https://gitlab.com/enricos83/ENHSP-Public) with the ROS framework (kinetic version).
It can be used to solve planning problems with linear and non-linear numerical expressions, for example.
It has four components (three nodes and one service server), inspired by the [ROSplan](https://github.com/KCL-Planning/ROSPlan) environment:

* Problem generator: Service server which generates STRIPS problems in PDDL
* Problem interface: Service client which calls the problem generator
* Planner interface: Node which gathers relevant information from ROS topics, as well as the STRIPS domain and problem, calls ENHSP to obtain a plan and publishes the plan in a ROS topic
* Planner dispatch: Gets the plan, parses it and executes the instructions (optional)


## Installation

The package can be installed via [CATKIN](http://docs.ros.org/api/catkin/html/).
The planner interface node also requires the repository's local copy of ENHSP to be installed.
To do this, open a terminal, navigate to the [planner's folder](https://github.com/rgmaidana/ros_enhsp/tree/master/common) and run "./install".


## Dependencies

The package has no explicit dependencies, except for ROS itself and ENHSP.
However, ROS and the [planner's dependencies](https://gitlab.com/enricos83/ENHSP-Public/tree/master#dependencies) still have to be met.

If running the application described below, then the [turtlebot](https://github.com/turtlebot/turtlebot) stack must be installed, as well as the Turtlebot 2 [simulator](http://wiki.ros.org/turtlebot_simulator) stack and ROS' [navigation](http://wiki.ros.org/navigation) stack.

## Application

The package is currently used for energy-efficient path planning in a simulated Turtlebot 2 robot.
The domain present in the "common" folder reflects this planning problem, which considers high-energy zones when choosing a path to a goal.
The energy-increasing and energy-decreasing actions are specific to a Jetson TX2 embedded computer, hard-coded in the planner dispatch node.
More information in [this paper](https://github.com/pucrs-automated-planning/term-projects-2018/blob/master/maidana/maidana-paper.pdf).


## Acknowledgements

* [Enrico Scala](https://gitlab.com/enricos83): Author of the ENHSP planner
* [Maurício Cecílio Magnaguagno](https://github.com/Maumagnaguagno): General help/tips with STRIPS planning and PDDL
* [Felipe Rech Meneguzzi](https://github.com/meneguzzi): Initial idea and help for this project


## To-Do:

* Fix minor movement bug in planner dispatch (steering angle jumps to -360 when robot yaw is close to 180 degrees, due to atan2 discontinuity at 180 degrees).
* Change planner interface node to load domain from ROS parameter.
* Generalize problem generator node to allow it to work with any planning problem.
