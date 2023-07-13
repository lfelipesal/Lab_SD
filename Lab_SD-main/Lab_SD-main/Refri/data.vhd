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

        display_prod : out std_logic_vector(0 to 6);
        display_val : out std_logic_vector(0 to 6);
        display_val_ac : out std_logic_vector(0 to 6);
        display_troco : out std_logic_vector(0 to 6);

        );
end;


architecture rtl of data is
    --declaração de componentes

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
    
    component valida_ficha is
        port (
        reg_ficha: in std_logic_vector(3 downto 0);
        ficha_valida : out std_logic
    );
    end component; 
    
    component valida_prod is
        port (
        reg_prod: in std_logic_vector(3 downto 0);
        prod_valida : out std_logic
    );
    end component; 

    component Demux is 
        port (
            enter  : in  std_logic;
            ctrl   : in  std_logic;
            ficha  : out std_logic;
            produto: out std_logic
    );
    end component;

    --declaração de sinais intermediários
    signal reg_prod: std_logic_vector(3 downto 0);
    signal reg_ficha: std_logic_vector(3 downto 0);
    signal reg_valor_prod: std_logic_vector(3 downto 0);
    signal reg_acu: std_logic_vector(3 downto 0);
    signal reg_troco: std_logic_vector(3 downto 0);
    
    signal ld_ficha: std_logic;
    signal ld_prod: std_logic;

    signal rom_out: std_logic_vector(3 downto 0);
    signal somador_out: std_logic_vector(3 downto 0);
    signal subtrator_out: std_logic_vector(3 downto 0);
    signal display_acumulado_out: std_logic_vector(3 downto 0);
    signal display_produto_out: std_logic_vector(0 to 6);
    signal display_preco_produto_out: std_logic_vector(0 to 6);
    signal display_troco_out: std_logic_vector(0 to 6);

    signal clk: std_logic;
    
    begin
    --instanciação de componentes

    my_demux: Demux 
     port map(
        enter => enter,
        ctrl => ctrl,
        ficha => ld_ficha,
        produto => ld_prod
     );

    my_ROM : ROM
    port map(
        produto_escolhido => reg_prod,
        preco_produto => rom_out,
        produto_existente => produto_valido
    );

    my_somador: somador
    port map(
        valor1 => reg_ficha,
        valor2 => reg_acu,
        resultado => somador_out
    );

    my_subtrator: subtrator
    port map(
        valor1 => reg_acu,
        valor2 => reg_valor_prod,
        resultado => subtrator_out
    );
    
    my_comparador_4: comparador_4
        port map (
            valor1 => reg_acu,
            valor2 => reg_valor_prod,
            lt => compra_valida
        );

    my_contador: contador
        port map (
            clock => clk,
            reset => reset,
            gt_or_eq => Cinco_time
        );
    
    my_conversor_produto: conversor
        port map (
            binary => reg_prod,
            hex => display_produto_out
        );
    
    my_conversor_preco_produto: conversor
        port map (
            binary => reg_valor_prod,
            hex => display_preco_produto_out
    );

    my_conversor_acumulado_e_troco: conversor
        port map (
            binary => display_acumulado_e_troco_in,
            hex => display_acumulado_e_troco_out
    );


    my_register_ficha: registrador_4
        port map(
            load => ld_ficha,
            reset => reset,
            clock => clock,
            entrada => ficha,
            saida => reg_ficha
        );
    

        my_register_produto: registrador_3
        port map(
            load =>ld_prod,
            reset => reset,
            clock => clock,
            entrada => produto,
            saida => reg_prod
        );

        my_register_valor_prod: registrador_3
        port map(
            load => ld_val_prod,
            reset => reset,
            clock => clock,
            entrada => rom_out,
            saida => reg_valor_prod
        );

        my_register_acumulador: registrador_4
        port map(
            load => ld_acumulador,
            reset => reset,
            clock => clock,
            entrada =>somador_out,
            saida => reg_acu
        );

        my_register_troco: registrador_4
        port map(
            load => ld_troco,
            reset => reset,
            clock => clock,
            entrada =>subtrator_out,
            saida => reg_troco
        );

        my_register_display_prod: registrador_7
        port map(
            load =>ld_display_prod,
            reset => reset,
            clock => clock,
            entrada => display_produto_out,
            saida => display_prod
        );

        my_register_display_val: registrador_7
        port map(
            load =>ld_display_val,
            reset => reset,
            clock => clock,
            entrada => display_preco_produto_out,
            saida => display_val
        );

        my_register_display_val_ac: registrador_7
        port map(
            load =>ld_display_val_ac,
            reset => reset,
            clock => clock,
            entrada => display_acumulado_out,
            saida => display_val_ac
        );

        my_register_display_troco: registrador_7
        port map(
            load =>ld_display_troco,
            reset => reset,
            clock => clock,
            entrada => display_troco_out,
            saida => display_troco
        );

end architecture;

