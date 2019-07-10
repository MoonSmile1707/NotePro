# Integration testing

<hr/>

Integration testing is the phase in software testing in which individual software modules are combined and tested as a group. Integration testing is conducted to evaluate the compliance of a system or component with specified in an integration test plan to those aggregates, and delivers as its output the integrated system ready for system testing.


## Approach

Some different types of integration testing are big-bing, mixed(sandwich), risky-harded, top-down, and bottom-up. Other Integration Patterns are: collaboration integration, backbone integration layer integration, client-sever integration, distributed services integration and high frequency integration.

In the big-bang approach, most of the developed modules are coupled together to form a complete software system or major part of the system and then used for integration testing. this method is very effective for saving time in the integration testing process. Howeer, if the test cases and thir results are not recorded properly, the entire integration process will be more complicated and may prevent the testing team from achieving the goal of tntegration testing. 

bottom-up testing is an approach to integrated testing where the lowest level components are tested first, then used to faciliate the testing of higher level components. the process is repeated until the component at the top of the hierarchy is testd. All the bottom or low-level modules, procedures or function are integrated and then testd. After the integration testing of lower levl integrated modules, the next level of modules will be formed and can be used for integration testing. This approach is helpful only when all or most of the modules of the same development level are ready. This method also helps to determine the levels of software devleoped and makes it easier to reprort testing progress in the form of a percentage.
Top-down testing is an approach to integrated testing where the top integrated moduls are tested and the branch of the module is tested stap by stap until the end of the related module.
Sandwich testing is an approach to combine top down testing with bottom up testing.
One limitation to this sort of testing is that any conditions not stated in specificed integration tests, outside of the confirmation of the execution of design items, will generally not be tested.

<hr/>

Get more inforamtion at [here](https://en.wikipedia.org/wiki/Integration_testing).
