
*** Settings ***
Documentation   Testing student rfill formegistration form
Library         Browser
Library         RPA.FileSystem
Library         BuiltIn
Library         String
Library         FakerLibrary    locale=en_US    seed=666
Library         Collections


*** Keywords ***
Make random data for test
    [Arguments]                ${Genders}
    # Generate some random data
    ${NAME}=                   FakerLibrary.Name
    ${SURNAME}=                FakerLibrary.Last Name
    ${EMAIL}=                  FakerLibrary.Email
    ${Address}=                FakerLibrary.Address
    # Use python code to get random item from list, random is python module
    ${Gender}=                 Evaluate   random.choice($Genders)   modules=random
    ${PHONE}=                  FakerLibrary.Random Number  digits=10  fix_len=True
    ${PHONE}=                  Convert To String  ${PHONE}
    ${year_of_birth}=          FakerLibrary.Random Int  min=1990  max=2100  step=1
    ${year_of_birth}=          Convert To String  ${year_of_birth}

    ${month_of_birth}=         FakerLibrary.Month Name
    ${day_of_birth}=           FakerLibrary.Random Int  min=1  max=28  step=1
    ${day_of_birth}=           Convert To String  ${day_of_birth}

    RETURN  ${NAME}  ${SURNAME}  ${EMAIL}  ${Address}  ${Gender}  ${PHONE}
    ...     ${year_of_birth}  ${month_of_birth}  ${day_of_birth}