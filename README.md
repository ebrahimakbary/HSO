# Holistic Swarm Optimization (HSO)

Holistic Swarm Optimization (HSO) is a **metaphor-less**, population-based optimization algorithm that utilizes the **entire population's fitness landscape** to guide search agents. Unlike traditional algorithms that rely on local or partial data, HSO balances **exploration and exploitation** through:

- Root Mean Squared (RMS)-based displacement coefficients
- Simulated Annealing-based selection
- Adaptive mutation

This MATLAB implementation follows the algorithm proposed in:

> **Holistic Swarm Optimization: A Novel Metaphor-less Algorithm Guided by Whole Population Information for Addressing Exploration-Exploitation Dilemma**  
> _Ebrahim Akbari, Abolfazl Rahimnejad, Stephen Andrew Gadsden_  
> 📄 [Journal Link](https://doi.org/10.1016/j.cma.2025.118208)  
> 📘 Elsevier - Computer Methods in Applied Mechanics and Engineering, 2025

---

## 🔧 How to Run

1. Open `HSO.m` in MATLAB.
2. Ensure `CostFunction.m` is in the same directory.
3. Press **Run** or type:

```matlab
HSO
```

By default, the algorithm minimizes the Sphere function:

```matlab
z = sum(x.^2);
```

You can replace `CostFunction.m` with any benchmark or real-world objective function of your choice.

---

## 📊 Sample Output

The algorithm prints iteration-wise best cost and plots a **convergence curve**:

```
Iter = 1, Best Cost = 2.764838e+04
Iter = 2, Best Cost = 1.974029e+04
...
Iter = 10000, Best Cost = 9.721004e-16
```


---

## 🗂 Folder Structure

```
HSO/
├── HSO.m                  % Main algorithm script
├── CostFunction.m         % Objective function (Sphere function)
├── README.md              % This file
├── LICENSE                % Open source license (MIT)

```

---

## 📌 Features

- Entire population used to compute directional displacement
- Displacement coefficients based on RMS fitness (global structure)
- Adaptive mutation with time-decaying parameters
- Simulated annealing-based acceptance to escape local optima
- Supports real-valued, high-dimensional optimization

---

## 📎 Requirements

- MATLAB R2016a or later
- No additional toolboxes needed

---

## 📜 License

This project is released under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 📬 Contact

For academic questions, contact:  
**Abolfazl Rahimnejad**  
📧 [a.rahimnejad@mcmaster.ca](mailto:a.rahimnejad@mcmaster.ca)

---

## ⭐ Acknowledgments

This implementation was created as a reference implementation of the HSO algorithm proposed in the published paper. Feel free to cite the article if you use this code in your work.
