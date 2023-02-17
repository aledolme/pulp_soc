library work;
use work.keccak_globals.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity keccak is
    port (
        clk     : in  std_logic;
        rst_n   : in  std_logic;
        start   : in std_logic;
        din     : in  std_logic_vector(1599 downto 0);
        dout    : out std_logic_vector(1599 downto 0);
        status  : out std_logic);
end keccak;

architecture rtl of keccak is
  --components
  component keccak_dp
    port (
        clk     : in  std_logic;
        rst_n   : in  std_logic;
        start_i : in std_logic;
        din     : in  std_logic_vector(1599 downto 0);
        ready_o : out std_logic;
        dout    : out std_logic_vector(1599 downto 0));
  end component;

  component keccak_cu
    port (
      clk_i      : in std_logic;
      rst_ni     : in std_logic;
      start_i    : in std_logic;
      ready_dp_i : in std_logic;
      start_dp_o : out std_logic;
      status     : out std_logic);
    end component; 
      
 -- interface with RF in keccak_top
    ----------------------------------------------------------------------------
   -- Internal signal declarations
    ----------------------------------------------------------------------------
  signal start_dp, permutation_computed : std_logic;
  begin -- Rtl
    -- port map
    DP : keccak_dp port map (
      clk        => clk,
      rst_n      => rst_n,
      start_i    => start_dp,
      din        => din,
      ready_o    => permutation_computed,
      dout       => dout);
      
    CU : keccak_cu port map (
      clk_i        => clk,
      rst_ni       => rst_n,
      start_i      => start,
      ready_dp_i   => permutation_computed, 
      start_dp_o   => start_dp,
      status       => status);
    
end rtl;
      
  

  
