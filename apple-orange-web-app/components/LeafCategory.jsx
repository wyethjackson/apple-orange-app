import React from 'react';
import Link from 'next/link';
import ProductCard from '@/components/ProductCard';
import { Description, Title, Subtitle } from '@/components/Typography';
export default function LeafCategory({ category }) {
    return (
            <div>
                <div >
                    {/* Breadcrumb or Category Indicator */}
                    <div className="flex items-center space-x-2 text-sm text-gray-600">
                        {(category?.breadcrumb || []).map((crumb, index) => (
                            <React.Fragment key={crumb.slug}>
                                <Link href={`/categories/${crumb.slug}`}>
                                    <span className="hover:underline cursor-pointer">{crumb.name}</span>
                                </Link>
                                {index < category?.breadcrumb.length - 1 && (
                                    <span className="mx-1">&gt;</span>
                                )}
                            </React.Fragment>
                        ))}
                    </div>
                    <Title>{category.title}</Title>
                    <div className="grid md:grid-cols-6 gap-10">
                        <div className="md:col-span-2">
                            <div className="flex space-x-4 overflow-x-auto md:overflow-x-visible">
                                {category.products.map((product, idx) => (
                                    <div key={idx} className="relative w-36 h-36 flex-shrink-0">
                                        <img
                                            src={product.imageSrc}
                                            alt={product.name}
                                            className="rounded object-cover w-full h-full"
                                        />
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>

                    <Description>{category.overview}</Description>    
                </div>
            

                <div className="py-8">
                {category.products.map((product, idx) => (
                    <ProductCard product={product} />
                ))}
                <div className="pt-8">
                    <Subtitle>In Conclusion...</Subtitle>
                    <Description>{category.conclusion}</Description>
                </div>
            </div>
        </div>
    );
}