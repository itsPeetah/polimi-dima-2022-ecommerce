type Product = {
  id: string;
  name: string;
  description: string;
  price: string;
  imgUrl: string;
};

export const emptyProduct: Product = {
  id: "",
  name: "",
  description: "",
  price: "0",
  imgUrl: "",
};

export default Product;
