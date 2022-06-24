import Product from "../types/product";
import "../App.css";
import { useEffect, useState } from "react";

export default function ProductInspector(props: {
  product: Product;
  onUpdate: (p: Product) => void;
  delete: () => void;
}) {
  const [product, setProduct] = useState<Product>(props.product);
  const [doDelete, setDoDelete] = useState(false);
  useEffect(() => {
    props.onUpdate({ ...product });
  }, [product]);

  return (
    <div className="product-container">
      <div className="row">
        <div>
          <span className="label">Product id:</span>
          <input
            value={product.id}
            onChange={(e) => setProduct({ ...product, id: e.target.value })}
          />
        </div>
        <div>
          <span className="label">Name:</span>
          <input
            value={product.name}
            onChange={(e) => setProduct({ ...product, name: e.target.value })}
          />
        </div>

        <div>
          <span className="label">Price:</span>
          <input
            type="number"
            value={product.price}
            onChange={(e) => setProduct({ ...product, price: e.target.value })}
          />
        </div>
        <div>
          <span className="label">Img url:</span>
          <input
            value={product.imgUrl}
            onChange={(e) => setProduct({ ...product, imgUrl: e.target.value })}
          />
        </div>
      </div>
      <div>
        Description: <br />
        <textarea rows={4} /> <br />
      </div>
      <div>
        <button
          className={doDelete ? "" : "red-btn"}
          onClick={() => setDoDelete(!doDelete)}
        >
          delete product
        </button>
        {doDelete ? (
          <>
            {" sure? ---> "}
            <button className="red-btn" onClick={() => props.delete()}>
              send it {Math.floor(Math.random() * 6 + 6)} feet deep
            </button>
          </>
        ) : null}
      </div>
    </div>
  );
}
