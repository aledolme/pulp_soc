#include <stdint.h>

void set_input_ntt_intt_pwm(uint16_t* Din);
void trigger_ntt(void);
void poll_done_ntt_intt_pwm(void);
void get_result_ntt_intt_pwm(uint16_t* Dout);
void KYBER_poly_ntt(uint16_t Din[256], uint16_t Dout[256]);

