// components/ProductCard.jsx
export default function ProductCard({ product }) {
    const toBulletList = (text) => {
        if(!text) return [];
        return text.split(",").map((item) => item.trim()).filter((item) => item.length).map((item) => item.charAt(0).toUpperCase() + item.slice(1));
    }
    
    return (
        <div className="relative border-2 border-orange-500 rounded-lg p-4 mt-4 mb-4 bg-white shadow-md max-w-3xl">
            
                <div className="absolute top-0 left-0 bg-orange-500 text-white text-sm font-medium px-3 py-1 rounded-br-lg">
                    {product.subtitle}
                </div>
            

            <div className="flex flex-col md:flex-row items-center gap-4 mt-4">
                {/* Product Image */}
                <div className="w-32 h-32 flex-shrink-0 flex items-center justify-center">
                    {/* If using Next.js <Image>, adjust width/height or layout */}
                    <img
                        src={product.imageSrc}
                        alt={product.name}
                        width={120}
                        height={120}
                        className="object-contain rounded"
                    />
                </div>

                {/* Text Content */}
                <div className="flex-1">
                    <h3 className="text-lg font-semibold text-gray-900">{product.name}</h3>
                    <p className="text-sm text-gray-600 mb-4">{product.description}</p>
                    <div className="flex flex-col md:flex-row gap-4 mb-4 w-full">
                        <div className="flex-1 min-w-0 bg-green-50 border-l-4 border-green-400 p-3 rounded">
                            <h4 className="text-green-700 font-semibold">✅ Pros</h4>
                            {/* <p className="text-sm text-gray-700">{product.pro_text}</p> */}
                            <ul className="list-disc list-inside space-y-1 text-gray-700 text-sm">
                                {toBulletList(product.pro_text).map((pro, idx) => (
                                    // <li key={idx}>{pro}</li>
                                    <li key={idx} className="flex items-start">
                                        <span className="mr-2">✨</span>
                                        <span className="flex-1">{pro}</span>
                                    </li>
                                ))}
                            </ul>
                        </div>
                        <div className="flex-1 min-w-0 bg-red-50 border-l-4 border-red-400 p-3 rounded">
                            <h4 className="text-red-700 font-semibold">❌ Cons</h4>
                            {/* <p className="text-sm text-gray-700">{product.con_text}</p> */}
                            <ul className="list-disc list-inside space-y-1 text-gray-700 text-sm">
                                {toBulletList(product.con_text).map((con, idx) => (
                                    // <li key={idx}>{con}</li>
                                    <li key={idx} className="flex items-start">
                                        <span className="mr-2">⚠️</span>
                                        <span className="flex-1">{con}</span>
                                    </li>
                                ))}
                            </ul>

                        </div>
                    </div>

                    {/* Offers / Prices */}
                    {/* <div className="space-y-2">
                            <div>
                                <Link
                                    href={product.link}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="text-base text-gray-900 font-semibold hover:underline"
                                >
                                    {`$${product.price}`}
                                </Link>
                            </div>
                    </div> */}
                    <div className="mt-4">
                        <a href={product.link} target="_blank" rel="noopener noreferrer">
                            <span target="_blank" rel="noopener noreferrer">
                                <button className="bg-gradient-to-r from-orange-500 to-orange-400 hover:from-orange-600 hover:to-orange-500 text-white font-semibold py-2 px-6 rounded-full shadow transition-colors duration-200">
                                    ${typeof product.price === 'number' ? product.price.toFixed(2) : 'N/A'} – View on Amazon
                                </button>
                            </span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    );
}
