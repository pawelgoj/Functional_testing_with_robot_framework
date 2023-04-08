
# Example how use user defined defind libs in Robot framework

*** Settings ***
Documentation     Test Login form

# User defined libs
Library           ../user_pop_lib/PlaywrightSettings.py
Library           ../user_pop_lib/pages/Login.py
Library           ../user_pop_lib/pages/Profile.py
Library           ../user_pop_lib/pages/BookStore.py
Library           ../user_pop_lib/pages/BookSummary.py

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
| ${book}                      |  Git Pocket Guide            |



*** test cases ***
Unregistered user fills out form
    [Documentation]  Unlogged user fills out form
    [Tags]  Negative test case
    # You can use name of lib befor key word eg. Login.Init login page
    # but is not necessary
    Login.Init Login Page                      ${page}
    ${name}                                    FakerLibrary.Name
    Login.Fill User Name Field                 ${name}
    ${password}                                FakerLibrary.Password  length=10  special_chars=True
    ...                                        digits=True  upper_case=True  lower_case=True
    Fill User Password                         ${password}
    Click Login Button
    Check Message To User                      Invalid username or password!
    # It is user defined "take screenshot" not form robot framework
    Take Screenshot                            ./resoults/test_unlogged_user.png
    # To add image to logs use html
    Log                                        <img src="test_unlogged_user.png">  html=yes


The registered user login and logout
    [Documentation]  The user login
    [Tags]  Positive test case
    # Keyword                                   Data
    ${page}  Log In To Profile Registered User

    Init Profile                                ${page}
    Check Logged To Profile                     ${Profie_url}
    Take Screenshot                             ./resoults/test_loged_user.png
    Log                                         <img src="test_loged_user.png">  html=yes


The registred user go to book store page
    [Documentation]  The user login
    [Tags]  Positive test case
    ${page}  Log in to profile registered user
    Init Profile                                 ${page}
    Check Logged To Profile                      ${Profie_url}
    Go To Book Store
    Init Book Store                              ${page}
    Check On Book Store                          ${Book_store_url}
    Take Screenshot                              ./resoults/test_book_store_page.png
    Log                                          <img src="test_book_store_page.png">  html=yes


The registered user select one book
    [Documentation]  The registered user select one book
    [Tags]  Positive test case
    ${page}  Log in to profile registered user
    Init Profile                                 ${page}
    Go To Book Store
    Init Book Store                              ${page}
    Select ${book} From List And Check Is In Summary


The registered user tries to delete account but dismiss dialog
    [Documentation]  The registered user tries to delete account
    ...              but dismiss dialog
    [Tags]  Positive test case
    ${page}  Log In To Profile Registered User
    Init Profile                          ${page}
    Try Delete But Dismiss Dialog
    Check Logged To Profile               ${Profie_url}
    Take Screenshot                       ./resoults/test_tries_to_delete_account_user.png
    Log                                   <img src="test_tries_to_delete_account_user.png">  html=yes


The registered user delete account
    [Documentation]  The registered user delete account
    [Tags]  Positive test case
    ${page}  Log In To Profile Registered User
    Init Profile                           ${page}
    Delete Account
    Check On Login Page                    ${Login_url}
    Take Screenshot                        ./resoults/test_loged_user.png
    Log                                    <img src="test_loged_user.png">  html=yes
    ${page}  Log In To Profile Registered User
    Check Message To User                  Invalid username or password!
    Take Screenshot                        ./resoults/test_unlogged_user.png
    Log                                    <img src="test_unlogged_user.png">  html=yes



*** Keywords ***
Tests Setup
    Launch Browser                         ${BROWSER}  ${Page_width}  ${Page_hight}
    ${page}  Open Web                      ${Login_url}
    Set Test Variable                      ${page}

Log in to profile registered user
    Init Login Page                        ${page}
    Fill User Name Field                   ${registeret_user_name}
    Fill User Password                     ${registered_user_password}
    Click Login Button
    RETURN                                 ${page}

Select ${book} From List And Check Is In Summary
    Select Book                            ${book}
    Init Book Summary                      ${page}
    Check Book Title In Summary            ${book}
    Take Screenshot                              ./resoults/test_book_summary_page.png
    Log                                          <img src="test_book_summary_page.png">  html=yes

