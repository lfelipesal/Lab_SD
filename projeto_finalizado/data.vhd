LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY data IS
    PORT (
        ctrl : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        produto : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ficha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        enter : IN STD_LOGIC;

        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        ld_val_prod : IN STD_LOGIC;
        ld_troco : IN STD_LOGIC;
        ld_display_prod : IN STD_LOGIC;
        ld_display_val : IN STD_LOGIC;
        ld_display_val_ac : IN STD_LOGIC;
        ld_display_troco : IN STD_LOGIC;
        ld_acumulador : IN STD_LOGIC;
        ld_timer : IN STD_LOGIC;

        ficha_valida : OUT STD_LOGIC;
        produto_valido : OUT STD_LOGIC;
        compra_valida : OUT STD_LOGIC;

        Cinco_time : OUT STD_LOGIC;

        display_prod : OUT STD_LOGIC_VECTOR(0 TO 6);
        display_val : OUT STD_LOGIC_VECTOR(0 TO 6);
        display_val_ac : OUT STD_LOGIC_VECTOR(0 TO 6);
        display_troco : OUT STD_LOGIC_VECTOR(0 TO 6);

    );
END;
ARCHITECTURE rtl OF data IS
    --declaração de componentes

    COMPONENT ROM IS
        PORT (
            produto_escolhido : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            preco_produto : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            produto_existente : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT somador IS
        PORT (
            valor1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            valor2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            resultado : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT subtrator IS
        PORT (
            valor1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            valor2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            resultado : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT comparador_4 IS
        PORT (
            valor1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            valor2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            lt : OUT STD_LOGIC;
            gt : OUT STD_LOGIC;
            eq : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT contador IS
        PORT (
            clock : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            gt_or_eq : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT conversor IS
        PORT (
            binary : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            hex : OUT STD_LOGIC_VECTOR(0 TO 6)
        );
    END COMPONENT;

    COMPONENT valida_ficha IS
        PORT (
            reg_ficha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            ficha_valida : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT valida_prod IS
        PORT (
            reg_prod : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            prod_valida : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT Demux IS
        PORT (
            enter : IN STD_LOGIC;
            ctrl : IN STD_LOGIC;
            ficha : OUT STD_LOGIC;
            produto : OUT STD_LOGIC
        );
    END COMPONENT;

    --declaração de sinais intermediários
    SIGNAL reg_prod : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_ficha : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_valor_prod : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_acu : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_troco : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL ld_ficha : STD_LOGIC;
    SIGNAL ld_prod : STD_LOGIC;

    SIGNAL rom_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL somador_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL subtrator_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL display_acumulado_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL display_produto_out : STD_LOGIC_VECTOR(0 TO 6);
    SIGNAL display_preco_produto_out : STD_LOGIC_VECTOR(0 TO 6);
    SIGNAL display_troco_out : STD_LOGIC_VECTOR(0 TO 6);

    SIGNAL clk : STD_LOGIC;

BEGIN
    --instanciação de componentes

    my_valida_ficha : valida_ficha
    PORT MAP(
        reg_ficha => reg_ficha,
        ficha_valida => ficha_valida
    );

    my_demux : Demux
    PORT MAP(
        enter => enter,
        ctrl => ctrl,
        ficha => ld_ficha,
        produto => ld_prod
    );

    my_ROM : ROM
    PORT MAP(
        produto_escolhido => reg_prod,
        preco_produto => rom_out,
        produto_existente => produto_valido
    );

    my_somador : somador
    PORT MAP(
        valor1 => reg_ficha,
        valor2 => reg_acu,
        resultado => somador_out
    );

    my_subtrator : subtrator
    PORT MAP(
        valor1 => reg_acu,
        valor2 => reg_valor_prod,
        resultado => subtrator_out
    );

    my_comparador_4 : comparador_4
    PORT MAP(
        valor1 => reg_acu,
        valor2 => reg_valor_prod,
        lt => compra_valida
    );

    my_contador : contador
    PORT MAP(
        clock => clk,
        reset => reset,
        gt_or_eq => Cinco_time
    );

    my_conversor_produto : conversor
    PORT MAP(
        binary => reg_prod,
        hex => display_produto_out
    );

    my_conversor_preco_produto : conversor
    PORT MAP(
        binary => reg_valor_prod,
        hex => display_preco_produto_out
    );

    my_conversor_acumulado_e_troco : conversor
    PORT MAP(
        binary => display_acumulado_e_troco_in,
        hex => display_acumulado_e_troco_out
    );
    my_register_ficha : registrador_4
    PORT MAP(
        load => ld_ficha,
        reset => reset,
        clock => clock,
        entrada => ficha,
        saida => reg_ficha
    );
    my_register_produto : registrador_3
    PORT MAP(
        load => ld_prod,
        reset => reset,
        clock => clock,
        entrada => produto,
        saida => reg_prod
    );

    my_register_valor_prod : registrador_3
    PORT MAP(
        load => ld_val_prod,
        reset => reset,
        clock => clock,
        entrada => rom_out,
        saida => reg_valor_prod
    );

    my_register_acumulador : registrador_4
    PORT MAP(
        load => ld_acumulador,
        reset => reset,
        clock => clock,
        entrada => somador_out,
        saida => reg_acu
    );

    my_register_troco : registrador_4
    PORT MAP(
        load => ld_troco,
        reset => reset,
        clock => clock,
        entrada => subtrator_out,
        saida => reg_troco
    );

    my_register_display_prod : registrador_7
    PORT MAP(
        load => ld_display_prod,
        reset => reset,
        clock => clock,
        entrada => display_produto_out,
        saida => display_prod
    );

    my_register_display_val : registrador_7
    PORT MAP(
        load => ld_display_val,
        reset => reset,
        clock => clock,
        entrada => display_preco_produto_out,
        saida => display_val
    );

    my_register_display_val_ac : registrador_7
    PORT MAP(
        load => ld_display_val_ac,
        reset => reset,
        clock => clock,
        entrada => display_acumulado_out,
        saida => display_val_ac
    );

    my_register_display_troco : registrador_7
    PORT MAP(
        load => ld_display_troco,
        reset => reset,
        clock => clock,
        entrada => display_troco_out,
        saida => display_troco
    );

END ARCHITECTURE;