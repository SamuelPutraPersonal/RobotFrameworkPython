*** Settings ***
Documentation       A complete login test script for nopCommerce with bot-detection bypass.

Library             SeleniumLibrary
Resource            ../Basic/CommonKeywords.resource


*** Variables ***
${url}              https://demo.nopcommerce.com/
${email}            test@example.com
${password}         Test@123
${Execution_Env}    True    # Set to 'True' for Docker, 'False' for local execution


*** Test Cases ***
Login Test
    [Documentation]    Starts the browser with stealth options and performs login.
    Setup Browser For Test
    Set Selenium Speed    0.5 seconds
    Login To Application
    [Teardown]    Close Browser


*** Keywords ***
Setup Browser For Test
    # Using 'True' as a string to match the IF check in your Resource file
    Open Browser Custom    ${url}    ${Execution_Env}
    Sleep    2s

Login To Application
    # 1. Click the Login link at the top
    Wait Until Element Is Visible    xpath://a[@class='ico-login']    timeout=10s
    Click Link    xpath://a[@class='ico-login']

    # 2. Enter Credentials
    Wait Until Element Is Visible    id:Email    timeout=10s
    Input Text    id:Email    ${email}
    Input Password    id:Password    ${password}

    # 3. Click the Login button (Fixed the 'loqin' typo here)
    Click Button    xpath://button[contains(@class,'login-button')]
