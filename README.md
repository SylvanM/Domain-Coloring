# Domain-Coloring
This is a program that performs domain coloring of complex functions, as well as analyzing their properties.



## Graphing Complex Functions

This uses the same domain-coloring technique demonstrated in 3Blue1Brown's "[Winding numbers and domain coloring](https://www.youtube.com/watch?v=b7FxPsqfkOY)."

To choose what function you want to graph, go into "Function.swift" and edit the `function(_ z: VectorType) -> VectorType` definition:

```swift
static func function(_ z: VectorType) -> VectorType {
    1 / (z * z)
}
```

This will produce the graph

<img width="945" alt="Screenshot 2022-12-12 at 12 46 03" src="https://user-images.githubusercontent.com/32347646/207116660-a01eccb7-576f-4a23-91ca-088b5ff80bc1.png">


There are also plenty of pre-written example functions that you can play with, found in "Functions+Examples.swift" that can be used. Below is the result 
of using the example function `funRationalFunction`.

<img width="917" alt="Screenshot 2022-12-12 at 12 37 41" src="https://user-images.githubusercontent.com/32347646/207114901-b65e0901-d2ac-4d3e-ba6e-07c928e4c7f1.png">
<p align = "center">
Above is a graph of the complex rational function with a zero of order 2 at -1, a simple zero at 5, a pole of order 2 at 2i, and a simple pole at (-3 - i).
</p>
