*** Settings ***
Library     SeleniumLibrary


*** Variables ***
# These are only used when run_in_docker is True
${DOCKER_CHROME_BINARY}         /usr/bin/chromium
${DOCKER_CHROME_DRIVER_PATH}    /usr/bin/chromedriver


*** Keywords ***
Open Browser Custom
    [Arguments]    ${target_url}    ${run_in_docker}=False

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    IF    '${run_in_docker}' == 'True'
        # --- DOCKER / PIPELINE SETTINGS ---
        Call Method    ${options}    add_argument    --headless
        Call Method    ${options}    add_argument    --no-sandbox
        Call Method    ${options}    add_argument    --disable-dev-shm-usage
        ${options.binary_location}=    Set Variable    ${DOCKER_CHROME_BINARY}

        ${service}=    Evaluate
        ...    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path='${DOCKER_CHROME_DRIVER_PATH}')
        ...    sys, selenium.webdriver.chrome.service
        Create Webdriver    Chrome    options=${options}    service=${service}
    ELSE
        # On Mac, we don't set binary_location or service.
        # Selenium Manager will find your installed Chrome automatically.
        # --- LOCAL MAC STEALTH SETTINGS ---
        Call Method    ${options}    add_argument    --disable-blink-features\=AutomationControlled
        Call Method    ${options}    add_experimental_option    excludeSwitches    ${{['enable-automation']}}
        Call Method    ${options}    add_experimental_option    useAutomationExtension    ${False}

        Open Browser    ${target_url}    chrome    options=${options}

        # This Javascript execution hides the 'webdriver' flag from Cloudflare
        Execute Javascript    Object.defineProperty(navigator, 'webdriver', {get: () => undefined})

        Maximize Browser Window
    END

    Go To    ${target_url}
