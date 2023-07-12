library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity data is
    port(
        ctrl : in std_logic_vector(2 downto 0);
        produto : in std_logic_vector(2 downto 0);
        ficha : in  std_logic_vector(3 downto 0);
        enter : in std_logic;

        clock : in std_logic;
        reset : in std_logic;
    
        ld_val_prod : in std_logic;
        ld_troco : in std_logic;
        ld_display_prod : in std_logic;
        ld_display_val : in std_logic;
        ld_display_val_ac : in std_logic;
        ld_display_troco : in std_logic;
        ld_acumulador : in std_logic;
        ld_timer : in std_logic;
        

        ficha_valida : out std_logic;
        produto_valido : out std_logic;
        compra_valida : out std_logic;


        Cinco_time : out std_logic;

        display_prod : out std_logic_vector(7 downto 0);
        display_val : out std_logic_vector(7 downto 0);
        display_val_ac : out std_logic_vector(7 downto 0);
        display_troco : out std_logic_vector(7 downto 0)

        );
end;


architecture rtl of data is
    --declaração de componentes
    component DivisorClock is
        port 
        (
            CLOCK_50MHz : in std_logic;
            reset	      : in std_logic;
            CLOCK_1Hz   : out std_logic
        );
    
    end component;

    component ROM is
        port (
            produto_escolhido: in std_logic_vector(3 downto 0);
            preco_produto: out std_logic_vector(3 downto 0);
            produto_existente: out std_logic
        );
    end component;

    component somador is
        port (
            valor1: in std_logic_vector(3 downto 0);
            valor2: in std_logic_vector(3 downto 0);
            resultado: out std_logic_vector(3 downto 0)
        );
    end component;

    component subtrator is
        port (
            valor1: in std_logic_vector(3 downto 0);
            valor2: in std_logic_vector(3 downto 0);
            resultado: out std_logic_vector(3 downto 0)
        );
    end component;

    component comparador_4 is
        port (
            valor1: in std_logic_vector(3 downto 0);
            valor2: in std_logic_vector(3 downto 0);
            lt: out std_logic;
            gt: out std_logic;
            eq: out std_logic
        );
    end component;

    component contador is
        port (
            clock: in std_logic;
            reset: in std_logic;
            gt_or_eq: out std_logic
        );
    end component;

    component conversor is
        port (
            binary : in std_logic_vector(3 downto 0);
            hex : out std_logic_vector(0 to 6)
        );
    end component;

    
    

end architecture;

