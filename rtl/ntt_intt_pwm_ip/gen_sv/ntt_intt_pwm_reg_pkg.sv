// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package ntt_intt_pwm_reg_pkg;

  // Param list
  parameter int DIN = 1;
  parameter int DOUT = 1;
  parameter int CTRL = 1;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////
  typedef struct packed {
    logic [31:0] q;
  } ntt_intt_pwm_reg2hw_din_mreg_t;

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } load_a_f;
    struct packed {
      logic        q;
      logic        qe;
    } load_a_i;
    struct packed {
      logic        q;
      logic        qe;
    } load_b_f;
    struct packed {
      logic        q;
      logic        qe;
    } load_b_i;
    struct packed {
      logic        q;
      logic        qe;
    } read_a;
    struct packed {
      logic        q;
      logic        qe;
    } read_b;
    struct packed {
      logic        q;
      logic        qe;
    } start_ab;
    struct packed {
      logic        q;
      logic        qe;
    } start_ntt;
    struct packed {
      logic        q;
      logic        qe;
    } start_pwm;
    struct packed {
      logic        q;
      logic        qe;
    } start_intt;
  } ntt_intt_pwm_reg2hw_ctrl_mreg_t;


  typedef struct packed {
    logic [31:0] d;
  } ntt_intt_pwm_hw2reg_dout_mreg_t;

  typedef struct packed {
    logic        d;
  } ntt_intt_pwm_hw2reg_status_reg_t;


  ///////////////////////////////////////
  // Register to internal design logic //
  ///////////////////////////////////////
  typedef struct packed {
    ntt_intt_pwm_reg2hw_din_mreg_t [0:0] din; // [52:21]
    ntt_intt_pwm_reg2hw_ctrl_mreg_t [0:0] ctrl; // [20:1]
  } ntt_intt_pwm_reg2hw_t;

  ///////////////////////////////////////
  // Internal design logic to register //
  ///////////////////////////////////////
  typedef struct packed {
    ntt_intt_pwm_hw2reg_dout_mreg_t [0:0] dout; // [33:2]
    ntt_intt_pwm_hw2reg_status_reg_t status; // [1:2]
  } ntt_intt_pwm_hw2reg_t;

  // Register Address
  parameter logic [3:0] NTT_INTT_PWM_DIN_OFFSET = 4'h 0;
  parameter logic [3:0] NTT_INTT_PWM_DOUT_OFFSET = 4'h 4;
  parameter logic [3:0] NTT_INTT_PWM_CTRL_OFFSET = 4'h 8;
  parameter logic [3:0] NTT_INTT_PWM_STATUS_OFFSET = 4'h c;


  // Register Index
  typedef enum int {
    NTT_INTT_PWM_DIN,
    NTT_INTT_PWM_DOUT,
    NTT_INTT_PWM_CTRL,
    NTT_INTT_PWM_STATUS
  } ntt_intt_pwm_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] NTT_INTT_PWM_PERMIT [4] = '{
    4'b 1111, // index[0] NTT_INTT_PWM_DIN
    4'b 1111, // index[1] NTT_INTT_PWM_DOUT
    4'b 0011, // index[2] NTT_INTT_PWM_CTRL
    4'b 0001  // index[3] NTT_INTT_PWM_STATUS
  };
endpackage

