%% Holistic Swarm Optimization (HSO)

% Based on:
% "Holistic Swarm Optimization: A Novel Metaphor-less Algorithm Guided by Whole Population Information
% for Addressing Exploration-Exploitation Dilemma" 
% DOI: https://doi.org/10.1016/j.cma.2025.118208

clc;
clear;

%% Algorithm Parameters
nPop = 30;         % Population size
maxIt = 10000;     % Maximum number of iterations
alpha = 3;         % Scaling factor for position updates

% Simulated Annealing parameters
initialTemp = 10000;
coolingRate = 0.995;

% Adaptive Mutation parameters
initialMutationRate = 0.5;
finalMutationRate = 0.1;
initialMutationStep = 0.3;
finalMutationStep = 0.1;

%% Problem Definition
nVar = 30;              % Number of decision variables
varMin = -100;          % Lower bound
varMax = 100;           % Upper bound

%% Initialization
bestSol.position = zeros(1, nVar);
bestSol.cost = inf;

positions = rand(nPop, nVar) * (varMax - varMin) + varMin;
positionsNew = positions;

fitness = inf(1, nPop);
fitnessNew = fitness;

bestCosts = zeros(1, maxIt);
iter = 0;

%% Main Loop
while iter < maxIt
    temp = initialTemp * (coolingRate ^ iter);

    % Update adaptive mutation parameters
    mutationRate = initialMutationRate - iter * ((initialMutationRate - finalMutationRate) / maxIt);
    mutationStep = initialMutationStep - iter * ((initialMutationStep - finalMutationStep) / maxIt);

    for i = 1:nPop
        % Ensure positions remain within bounds
        positionsNew = max(min(positionsNew, varMax), varMin);

        % Evaluate fitness of each agent
        fitnessNew(i) = CostFunction(positionsNew(i, :));

        % Selection using greedy and SA-based criteria
        if fitnessNew(i) < fitness(i)
            positions(i, :) = positionsNew(i, :);
            fitness(i) = fitnessNew(i);
        else
            delta = fitnessNew(i) - fitness(i);
            if exp(-delta / temp) > rand
                positions(i, :) = positionsNew(i, :);
                fitness(i) = fitnessNew(i);
            end
        end
    end

    % Sort and archive best solution
    [fitness, idx] = sort(fitness);
    positions = positions(idx, :);

    if fitness(1) < bestSol.cost
        bestSol.cost = fitness(1);
        bestSol.position = positions(1, :);
    end

    %% Coefficient Calculation (simplified, without sign)
    fitnessVector = fitness(:);
    differences = rms(fitnessVector) - fitnessVector;
    updateCoef = differences / sum(abs(differences));

    %% Position Update
    for i = 1:nPop
        for j = 1:nVar
            randWeights = rand(nPop, 1);
            displacement = alpha * sum(randWeights .* updateCoef .* (positions(:, j) - positions(i, j)));
            positionsNew(i, j) = positions(i, j) + displacement;
        end
    end

    %% Adaptive Mutation
    for i = 1:nPop
        if rand < mutationRate
            mutationVector = mutationStep * randn(1, nVar);
            positionsNew(i, :) = positionsNew(i, :) + mutationVector;
        end
    end

    iter = iter + 1;
    bestCosts(iter) = bestSol.cost;

    fprintf('Iter = %d, Best Cost = %.10f\n', iter, bestSol.cost);
end

%% Convergence Plot
figure;
semilogy(1:iter, bestCosts, 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Best Cost');
title('Convergence Curve of HSO');
grid on;
