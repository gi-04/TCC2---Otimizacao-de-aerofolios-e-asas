function dat = error_check_naca4_3D(dat)

% Par�metros do algoritmo: tamanho da popula��o
if rem(dat.N,2) ~= 0
    warning('Tamanho da popula��o deve ser par. O valor inserido ser� alterado'),pause(5)
    dat.N = dat.N + 1;
end

% Par�metros do algoritmo: chance de muta��o
if dat.mu < 0 || dat.mu > 1
    error('Chance de muta��o deve estar no intervalo 0 <= dat.mu <= 1')
end

% Par�metros do algoritmo: n�mero de itera��es
if dat.iter < 1 || dat.iter ~= floor(dat.iter)
    error('N�mero de itera��es do algoritmo deve ser positivo, n�o nulo e inteiro')
end

% Par�metros da geometria: propor��o de tipos de planta
if dat.planf_op < 0 || dat.planf_op > 1
	error('A propor��o de tipos de planta deve estar no intervalo 0 <= dat.planf_op <= 1')
end

% Par�metros da geometria: configura��o 'L' da corda do meio e do perfil do meio
if dat.planf_op ~= 0 && ismember('L',dat.c_m_ext_in) && ismember('L',dat.m_ext_m)
	error("Configura��es da geometria transformar�o todas as asas bitrapezoidais em trapezoidais simples (rever op��es 'L')")
end

% Par�metros da geometria: extens�o da envergadura da primeira se��o b1
if dat.b1_ext_in(1) >= dat.b_ext_in(2) && dat.planf_op ~= 0
	error('O valor m�nimo da extens�o de b1 deve sempre ser menor que o valor m�ximo da extens�o de b')
end

% Par�metros da geometria: extens�o da envergadura da primeira se��o b1
if dat.b1_ext_in(3) <= 0 && dat.planf_op ~= 0
	error('A separa��o m�nima entre b1 e b deve ser um valor positivo n�o nulo')
end

% Par�metros da geometria: extens�o da corda do meio
if dat.c_m_ext_in(2) > dat.c_r_ext_in(2) && dat.planf_op ~= 0
	error('O valor m�ximo da extens�o de c_m deve ser menor ou igual ao valor da extens�o m�xima da extens�o de c_r')
end

if dat.c_m_ext_in(1) < dat.c_t_ext_in(1) && dat.planf_op ~= 0
	error('O valor m�nimo da extens�o de c_m deve ser maior ou igual ao valor m�nimo da extens�o de c_t')
end

% Par�metros da geometria: aerof�lio da raiz
if dat.m_ext_r(1) < 0 || dat.m_ext_r(2) > 9
    error('Aerof�lio da raiz: extens�o de m deve ser especificada de 0 a 9')
end
if dat.p_ext_r(1) < 1 || dat.p_ext_r(2) > 9
    error('Aerof�lio da raiz: extens�o de p deve ser especificada de 1 a 9')
end
if dat.t_ext_r(1) < 1 || dat.t_ext_r(2) > 99
    error('Aerof�lio da raiz: extens�o de t deve ser especificada de 1 a 99')
end

% Par�metros da geometria: aerof�lio do meio
if dat.planf_op ~= 0
	if dat.m_ext_m(1) < 0 || dat.m_ext_m(2) > 9
		error('Aerof�lio do meio: extens�o de m deve ser especificada de 0 a 9')
	end
	if dat.p_ext_m(1) < 1 || dat.p_ext_m(2) > 9
		error('Aerof�lio do meio: extens�o de p deve ser especificada de 1 a 9')
	end
	if dat.t_ext_m(1) < 1 || dat.t_ext_m(2) > 99
		error('Aerof�lio do meio: extens�o de t deve ser especificada de 1 a 99')
	end
end

% Par�metros da geometria: aerof�lio da ponta
if dat.m_ext_t(1) < 0 || dat.m_ext_t(2) > 9
    error('Aerof�lio da ponta: extens�o de m deve ser especificada de 0 a 9')
end
if dat.p_ext_t(1) < 1 || dat.p_ext_t(2) > 9
    error('Aerof�lio da ponta: extens�o de p deve ser especificada de 1 a 9')
end
if dat.t_ext_t(1) < 1 || dat.t_ext_t(2) > 99
    error('Aerof�lio da ponta: extens�o de t deve ser especificada de 1 a 99')
end

% Par�metros das simula��es: n�mero de condi��es de voo
if dat.cases < 1 || dat.cases ~= floor(dat.cases)
	error('N�mero de condi��es de voo deve ser positivo, n�o nulo e inteiro')
end

% Par�metros das simula��es: velocidades de refer�ncia
if length(dat.v_ref) < dat.cases
	error('N�o h� velocidades de refer�ncia suficientes para todas as condi��es de voo')
end

% Par�metros das simula��es: densidades do ar
if length(dat.rho) < dat.cases
	error('N�o h� densidades do ar suficientes para todas as condi��es de voo')
end 

% Par�metros das simula��es: press�es atmosf�ricas
if length(dat.p_atm) < dat.cases
	error('N�o h� press�es atmosf�ricas suficientes para todas as condi��es de voo')
end

% Par�metros das simula��es: n�meros de Mach
if length(dat.mach) < dat.cases
	error('N�o h� n�meros de Mach suficientes para todas as condi��es de voo')
end

% Par�metros das simula��es: n�meros de Reynolds
if length(dat.reynolds) < dat.cases 
    error('N�o h� n�meros de Reynolds suficientes para todas as condi��es de voo')
end

% Par�metros das simula��es: �ngulos de ataque
if length(dat.aoa) < dat.cases 
    error('N�o h� �ngulos de ataque suficientes para todas as condi��es de voo')
end

%if length(dat.iter_sim) < dat.cases
%    error('N�o h� n�meros de itera��es (XFOIL) suficientes para todas as condi��es de voo')
%end

% % Trocar valores nulos e negativos de n�meros de itera��o pelo valor padr�o do XFOIL
% for i = 1:dat.cases
	% if dat.iter_sim(i) == 0
		% dat.iter_sim(i) = 10;
	% end
% end

% Par�metros das simula��es: configura��o das fun��es objetivo
if size(dat.coeff_op,1) < dat.cases || size(dat.coeff_val,1) < dat.cases || size(dat.coeff_F,1) < dat.cases
    error('Configura��es das fun��es objetivo s�o insuficientes para todas as condi��es de voo')
end

% Par�metros das simula��es: fun��o objetivo 'q' para for�a de sustenta��o, for�a de arrasto e momento de arfagem
if ismember('q',dat.coeff_op(:,3))
	error('fun��o objetivo q vale apenas para a sustenta��o, arrasto e momento')
end

% par�metros das simula��es: fun��o objetivo '|' para for�a de sustenta��o e de arrasto
if ismember('#',dat.coeff_op(:,3:4))
	error('fun��o objetivo # vale apenas para sustenta��o e arrasto')
end

% Par�metros das simula��es: fun��es objetivo de coeficiente de momento
if ismember('c',dat.coeff_op(:,1:3)) || ismember('k',dat.coeff_op(:,1:3))
    error('fun��es objetivo c e k valem apenas para o coeficiente de momento')
end

% Par�metros das simula��es: fun��es objetivo de coeficientes de momento referentes a m�ltiplas condi��es de voo
if dat.cases == 1 && dat.coeff_op(1,4) == 'c' || dat.cases == 1 && dat.coeff_op(1,4) == 'k'
    warning('fun��o objetivo c/k vale apenas para m�ltiplas condi��es de voo. A mesma ser� ignorada.')
    dat.coeff_op(1,4) = '!'; pause(5)
end

if sum(sum(dat.coeff_op(1:dat.cases,:) == '!')) == numel(dat.coeff_op(1:dat.cases,:)),
    error('Ao menos uma das fun��es objetivo deve estar ativa')
end

% PAr�metros das simula��es: fun��es objetivo (geral)
T = dat.coeff_op;
for i = 1:dat.cases
	for j = 1:4
		if T(i,j) ~= '!' && T(i,j) ~= '^' && T(i,j) ~= 'o' && T(i,j) ~= 'q' && T(i,j) ~= '#' && T(i,j) ~= 'c' && T(i,j) ~= 'k'
			error('A matriz dat.coeff_op deve ser definida com op��es !, ^, o, q, #, c ou k')
		end
	end
end

if dat.cases > 1
	for i = 2:dat.cases
        if sum(dat.coeff_op(i,:) == '!') == 4 && dat.coeff_op(1,4) ~= 'c' && dat.coeff_op(1,4) ~= 'k'
			error(['Condi��o de voo ' num2str(i) ' n�o tem fun��o objetivo definida'])
		end
	end
end

for P = 1:dat.cases
    if dat.coeff_op(P,2) == 'o' && dat.coeff_val(P,2) < 0
        error(['Condi��o de voo ' num2str(P) ': CD alvo deve ser maior que zero'])
    elseif dat.coeff_op(P,2) == 'o' && dat.coeff_val(P,2) == 0
        dat.coeff_op(P,2) = '^';
        warning(['Condi��o de voo ' num2str(P) ': CD = 0 - fun��o objetivo de arrasto trocada de o para ^']),pause(5)
    end
end

if dat.cases > 1 && dat.coeff_op(1,4) == 'c' || dat.cases > 1 && dat.coeff_op(1,4) == 'k'
	if sum(dat.coeff_op(2:end,4) ~= '!') ~= 0
		warning('fun��o objetivo de momento c/k: fun��es objetivo das condi��es de voo subsequentes ser�o ignoradas'),pause(5)
		dat.coeff_op(2:dat.cases,4) = repmat('!',dat.cases-1,1);
	end	
end