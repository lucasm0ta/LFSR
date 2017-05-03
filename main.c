#include <stdint.h>
#include <math.h>
#include <stdio.h>

uint32_t lfsr_c(uint32_t seed);

// Seed
uint32_t seed = 0x0C73;

int main() {
    int recurrence[4096]; // Bits range;

    int counter;
    // Set all recurrences to 0
    for (counter = 0; counter < 4096; counter++) {
        recurrence[counter] = 0;
    }

    // Adds randoms to its recurrence range
    for (counter = 0; counter < 0x1000000; counter++) {
        uint32_t test = lfsr_c(seed);
        recurrence[(test & 0x0fff)%4096]++; // Masks first bits to use just 24
        seed = test;
    }
    // Calculate chi-squared
    double ret = 0;
    for (counter = 0; counter < 4096; counter++) {
        printf("%d:%d\n", counter, recurrence[counter]);
        ret += pow(recurrence[counter] - 4096, 2) / 4096;
    }
    printf("X^2_4096 = %lf", ret);

}
uint32_t lfsr_c(uint32_t seed) {
    uint32_t start_state = seed; // Bitmask to have just 24bits
    uint32_t lfsr = start_state;
    uint32_t bit;                    // Must be 32bit to allow bit << 21 later in the code
    unsigned period = 0;

    // Taps: 24 22 21 19 16 11 3; Polynomial: x^24 + x^22 + x^21 + x^19 + x^16 + x^11 + x^3 + 1
    bit  = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ^ (lfsr >> 8) ^ (lfsr >> 13) ^ (lfsr >> 21))& 1;
    lfsr =  (lfsr >> 1) | (bit << 23);

    return lfsr; // Bitmask to have just 24bits
}
