// components/ProductCard.jsx
export default function ProductCard({ product }) {
    return (
        <div className="p-4 border rounded-lg shadow hover:shadow-lg">
            <h3 className="text-xl font-medium">{product.name}</h3>
            <p className="mt-2 font-semibold text-green-600">{product.price}</p>
        </div>
    );
}
