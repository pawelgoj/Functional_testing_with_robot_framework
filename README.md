
# Exemplary tests in Robot framework

The project presents sample tests using the Robot Framework and Browser library. 
It also shows how to create custom test libraries in python, Playwright and Page object pattern, 
which can be used with Robot framework. 

- In *test/tests_fill_out_the_form.robot* file and *resources/* directory, you find tests using **"Browser"** library 
for Robot Framework. This library uses playwright Node module, and it is a very powerful tool. In **resources/** 
directory, you find modules with user defined keywords. These files are similarly arranged as classes in the PoP 
pattern for object-oriented languages. One file with keywords definitions represent only one Page of
website or component, e.g. form.

- In *test/tests_fill_out_the_form.robot* you find Robot Framework tests using user test library. This library you find
in *user_pop_lib*. This library implements page object pattern and was written in python using the playwright. 

The random data for tests are obtained using the FakerLibrary for robot framework.

## If you would like to experiment with this project, here are some commands you may find useful:

 `robot -d resoults  tests` <- run tests. "resoults"- log and report directory, 
 tests- directory with tests

 `playwright codegen` <- playwright useful tool to get locators and some code sniplets

 `playwright show-trace .\trace.zip` <- useful playwright tool e.g. for debugging tests. 
 You can trace everything that happened during the test.
 
 `rfbrowser show-trace -F trace.zip` <- command for *browser* lib. It is the same as `playwright show-trace .\trace.zip`

 ### Installation dependencies:

 `pip install robotframework-faker` <- Install **FakerLibrary** for robot framework

 ##### For Playwright using tests
 `pip install playwright` <- Install playwright for user test library

 `playwright install` <- install the playwright browser 

 ##### For Browser robot framework library using tests
 `pip install -U robotframework-browser` <- install **Browser**

 `rfbrowser clean-node` <- clean node

 `rfbrowser init` <- init/install all requirements for **Browser**


## Tools

- Python
- Robot framework
- Browser <- robot framework library
- FakerLibrary <- robot framework library
- Playwright
