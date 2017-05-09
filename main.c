/*!
 * Algoritmo LFSR - Trabalho SB 3
 *
 * Alunos:
 *      Breno Xavier Pinto      130103845
 *      Gabriel Naves da Silva  120011867
 *      Lucas Mota Ribeiro      120016995
 */

#include <stdint.h>
#include <math.h>
#include <stdio.h>

uint32_t lfsr_c(uint32_t seed);
extern uint32_t lfsr_nasm(uint32_t seed); // Necessário para incluir o nasm

// Seed
uint32_t seed_c = 0x0C72;
uint32_t seed_nasm = 0x0C72;

/*!
 * Função Principal.
 */
int main() {
    int recurrence_c[4096]; // Recorrencia nos intervalos do algoritmo em C
    int recurrence_nasm[4096];; // Recorrencia nos intervalos do algoritmo em C

    int counter;
    // Seta todas as recorrências para 0
    for (counter = 0; counter < 4096; counter++) {
        recurrence_c[counter] = 0;
        recurrence_nasm[counter] = 0;
    }

    // Adiciona os numeros randômicos para ses respectivos intervalos de recorrência.
    for (counter = 0; counter < 0x1000000; counter++) {
        // printf("in:(%x, %x)", seed_c, seed_nasm);
        uint32_t test_c = lfsr_c(seed_c);
        uint32_t test_nasm = lfsr_nasm(seed_nasm);
        // printf("|out:(%x, %x)\n",test_c, test_nasm);

        recurrence_c[(test_c & 0x00ffffff) / 4096]++; // Masks first bits to use just 24
        recurrence_nasm[(test_nasm & 0x00ffffff) % 4096]++; // Masks first bits to use just 24

        seed_c = test_c;
        seed_nasm = test_nasm;
    }

    // Calcula o chi-quiadrado
    double ret_c = 0, ret_nasm = 0;
    for (counter = 0; counter < 4096; counter++) {
        ret_c += pow(recurrence_c[counter] - 4096, 2) / 4096;
        ret_nasm += pow(recurrence_nasm[counter] - 4096, 2) / 4096;
    }
    printf("\nC   : X^2_4096 = %lf \n", ret_c);
    printf("NASM: X^2_4096 = %lf \n", ret_nasm);

}

/*!
 * Esta função retorna o argumento depois de passar por uma rodada do LFSR
 */
uint32_t lfsr_c(uint32_t seed) {
    uint32_t lfsr = seed;
    uint32_t bit;
    unsigned period = 0;

    // Taps: 24 22 21 19 16 11 3; Polinomio: x^24 + x^22 + x^21 + x^19 + x^16 + x^11 + x^3 + 1
    bit  = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ^ (lfsr >> 8) ^ (lfsr >> 13) ^ (lfsr >> 21)) & 1;
    // printf("\nbit(c): %x\n", bit);
    lfsr =  (lfsr >> 1) | (bit << 23);

    return lfsr; // Bitmask para 24bits
}
