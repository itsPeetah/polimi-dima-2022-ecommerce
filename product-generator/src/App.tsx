import React, { useState } from "react";
import logo from "./logo.svg";
import "./App.css";
import Product, { emptyProduct } from "./types/product";
import ProductInspector from "./components/product";

function App() {
  const [products, setProducts] = useState<Product[]>([]);
  const [showInspector, setShowInspector] = useState(true);
  const [showPOutput, setShowPOutput] = useState(false);
  const [pOutput, setPOutput] = useState("output empty...");
  const addNewProduct = () => {
    setProducts([...products, { ...emptyProduct }]);
  };

  const updateProductAtIndex = (idx: number, product: Product) => {
    const ps = [...products];
    ps[idx] = product;
    setProducts(ps);
  };

  const deleteProduct = (idx: number) => {
    const ps: Product[] = [];
    products.forEach((p, i) => {
      if (i !== idx) ps.push(p);
    });
    setProducts(ps);
    // This is dirty afff but I can't be bothered finding a solution rn
    setShowInspector(false);
    setTimeout(() => setShowInspector(true), 10);
  };

  const exportList = () => {
    const t: any = {};
    products.forEach((p) => {
      if (p.id.length > 0) t[p.id] = p;
    });
    setPOutput(JSON.stringify(t));
  };

  const buildBody = () => {
    const ps: any[] = [];

    products.forEach((p, i) => {
      ps.push(
        <ProductInspector
          key={`p_${i}`}
          product={p}
          onUpdate={(product) => {
            updateProductAtIndex(i, product);
          }}
          delete={() => deleteProduct(i)}
        />
      );
    });
    return ps;
  };

  return (
    <div className="container">
      <h1>Product editor</h1>
      <div className="row">
        <span className="lable">Show inspector</span>
        <input
          type="checkbox"
          checked={showInspector}
          onChange={() => setShowInspector(!showInspector)}
        />
        <div className="row-divider">|</div>
        <span className="lable">Show output</span>
        <input
          type="checkbox"
          checked={showPOutput}
          onChange={() => setShowPOutput(!showPOutput)}
        />
        <div className="row-divider">|</div>
        <button onClick={exportList}>Export Products</button>
      </div>

      {showInspector ? (
        <>
          {buildBody()}
          <div className="divider" />
          <div className="container">
            <button className="add-btn" onClick={addNewProduct}>
              Add new product
            </button>
          </div>
        </>
      ) : null}
      {showPOutput ? (
        <>
          <div className="divider" />
          {pOutput}
        </>
      ) : null}
    </div>
  );
}

export default App;
