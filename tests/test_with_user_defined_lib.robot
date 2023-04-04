
# Example how use user defined defind libs in Robot framework

*** Settings ***
Documentation     Test Login form

# User defined libs
Library           ../user_pop_lib/PlaywrightSettings.py
Library           ../user_pop_lib/pages/Login.py
Library           ../user_pop_lib/pages/Profile.py
Library           ../user_pop_lib/pages/BookStore.py


Library           FakerLibrary    locale=en_US    seed=666

Test Setup        Tests Setup
Test Teardown     close browser
Suite Teardown    Log  'Done!'



*** Variables ***
| ${BROWSER}                   |  chromium                    |
| ${Page_width}                |  1920                        |
| ${Page_hight}                |  1080                        |
| ${Login_url}                 |  https://demoqa.com/login    |
| ${Profie_url}                |  https://demoqa.com/profile  |
| ${Book_store_url}            |  https://demoqa.com/books    |
| ${registeret_user_name}      |  Test                        |
| ${registered_user_password}  |  \#SuperPasword123456        |



*** test cases ***
Unregistered user fills out form
    [Documentation]  Unlogged user fills out form
    [Tags]  Negative test case
    # You can use name of lib befor key word eg. Login.Init login page
    # but is not necessary
    Login.Init login page                      ${page}
    ${name}                                    FakerLibrary.Name
    Login.fill user name field                 ${name}
    ${password}                                FakerLibrary.Password  length=10  special_chars=True
    ...                                        digits=True  upper_case=True  lower_case=True
    fill user password                         ${password}
    click login button
    check message to user                      Invalid username or password!
    # It is user defined "take screenshot" not form robot framework
    take screenshot                            ./resoults/test_unlogged_user.png
    # To add image to logs use html
    Log                                        <img src="test_unlogged_user.png">  html=yes


The registered user login and logout
    [Documentation]  The user login
    [Tags]  Positive test case
    # Keyword                                   Data
    ${page}  Log in to profile registered user

    init profile                                ${page}
    check logged to profile                     ${Profie_url}
    take screenshot                             ./resoults/test_loged_user.png
    Log                                         <img src="test_loged_user.png">  html=yes


The registred user go to book store page
    [Documentation]  The user login
    [Tags]  Positive test case
    ${page}  Log in to profile registered user
    init profile                                 ${page}
    check logged to profile                      ${Profie_url}
    go to book store
    init book store                              ${page}
    check on book store                          ${Book_store_url}
    take screenshot                              ./resoults/test_book_store_page.png
    Log                                          <img src="test_book_store_page.png">  html=yes


The registered user tries to delete account but dismiss dialog
    [Documentation]  The registered user tries to delete account
    ...              but dismiss dialog
    [Tags]  Positive test case
    ${page}  Log in to profile registered user
    init profile                          ${page}
    try delete but dismiss dialog
    check logged to profile               ${Profie_url}
    take screenshot                       ./resoults/test_tries_to_delete_account_user.png
    Log                                   <img src="test_tries_to_delete_account_user.png">  html=yes


The registered user delete account
    [Documentation]  The registered user delete account
    [Tags]  Positive test case
    ${page}  Log in to profile registered user
    init profile                           ${page}
    delete account
    check on login page                    ${Login_url}
    take screenshot                        ./resoults/test_loged_user.png
    Log                                    <img src="test_loged_user.png">  html=yes
    ${page}  Log in to profile registered user
    check message to user                  Invalid username or password!
    take screenshot                        ./resoults/test_unlogged_user.png
    Log                                    <img src="test_unlogged_user.png">  html=yes



*** Keywords ***
Tests Setup
    launch browser                         ${BROWSER}  ${Page_width}  ${Page_hight}
    ${page}  open web                      ${Login_url}
    Set Test Variable                      ${page}

Log in to profile registered user
    Init login page                        ${page}
    fill user name field                   ${registeret_user_name}
    fill user password                     ${registered_user_password}
    click login button
    RETURN                                 ${page}
