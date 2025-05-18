// components/CategoryNav.jsx
import Link from 'next/link';

export default function CategoryNav({ categories }) {
    return (
        <nav className="bg-orange-50 border-b border-orange-200">
            <div className="max-w-5xl mx-auto space-x-6 w-full sm:max-w-full md:max-w-3xl lg:max-w-5xl xl:max-w-6xl mx-auto px-4 flex items-center relative">
                {(categories || []).map((cat) => (
                    <div key={cat.slug} className="relative group">
                        <Link href={`/categories/${cat.slug}`}>
                            <span className="text-orange-700 font-medium hover:text-orange-900 inline-block py-2">
                                {cat.name}
                            </span>
                        </Link>
                        {cat.children && cat.children.length > 0 && (
                            <div className="absolute left-0 top-full bg-white border border-gray-200 rounded shadow-lg w-56 hidden group-hover:block z-50">
                                {cat.children.map((subcat) => (
                                    <Link href={`/categories/${subcat.slug}`} key={subcat.slug}>
                                        <span className="block px-4 py-2 text-gray-700 hover:bg-gray-100 cursor-pointer">
                                            {subcat.name}
                                        </span>
                                    </Link>
                                ))}
                            </div>
                        )}
                    </div>
                ))}
            </div>
        </nav>
    );
    // return (
    //     <nav className="bg-orange-50 border-b border-orange-200">
    //         {/* Ensure identical container class as above */}
    //         <div className="max-w-5xl mx-auto px-4 py-2 flex space-x-6">
    //             {(categories || []).map((cat) => (
    //                 <div key={cat.slug} className="relative group">
    //                     <Link href={`/${cat.slug}`}>
    //                         <span className="text-orange-700 font-medium hover:text-orange-900 inline-block py-2 cursor-pointer">
    //                             {cat.name}
    //                         </span>
    //                     </Link>
    //                     {cat.children && cat.children.length > 0 && (
    //                         <div className="absolute left-0 top-full bg-white border border-gray-200 rounded shadow-lg w-56 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-opacity duration-200 z-50">
    //                             {cat.children.map((subcat) => (
    //                                 <Link href={`/${subcat.slug}`} key={subcat.slug}>
    //                                     <span className="block px-4 py-2 text-gray-700 hover:bg-gray-100 cursor-pointer">
    //                                         {subcat.name}
    //                                     </span>
    //                                 </Link>
    //                             ))}
    //                         </div>
    //                     )}
    //                 </div>
    //             ))}
    //         </div>
    //     </nav>
    // );
}
