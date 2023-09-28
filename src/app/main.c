#include <stdbool.h>
#include "cubemx_main.h"

int main() {

    cubemx_main();

    while (true) {
        HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_SET);
        HAL_Delay(100);
        HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, GPIO_PIN_RESET);
        HAL_Delay(100);
    }

    return 0;
}
