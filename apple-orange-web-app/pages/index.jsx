// pages/index.jsx
import BlogCard from '../components/BlogCard';
import ProductCard from '../components/ProductCard';
import {Title} from '../components/Typography'
import React from 'react';
import Layout from '@/components/Layout';
import testCategoryWithChildData from '@/utils/test_category_with_child_data.json';
import fetch from 'node-fetch';

export default function Home({featuredLeafCategories, allCategories}) {

    return (
        <Layout categories={allCategories}>
        <div className="max-w-6xl mx-auto px-4 py-12">
            {/* Hero Section */}
            <div className="mb-10 text-center">
                <h1 className="text-4xl font-bold text-orange-700 mb-2">Your Guide to Better Buying</h1>
                <p className="text-lg text-gray-600">
                    Browse curated product comparisons across electronics, kitchen tools, and more.
                </p>
            </div>

            {/* Grid of Comparisons */}
            <div className="grid sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                {(featuredLeafCategories || []).map((cat) => (
                    <CategoryLeafCard
                        key={cat.slug}
                        slug={cat.slug}
                        title={cat.name}
                        breadcrumbs={cat.breadcrumbs}
                    />
                ))}
            </div>
        </div>
        </Layout>
    );
}

export async function getServerSideProps(context) {

    try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_BASE_URL}/api`);

        if (!res.ok) {
            return { props: { data: null, slug } };
        }

        const data = await res.json();
        // const data = testCategoryData;
        // const data = testCategoryWithChildData;

        const {category} = data;
        const imageData = await fetch(`${process.env.NEXT_PUBLIC_R2_ASSETS}/${category?.products[0]?.image_file}`);
        console.log(imageData);
        const image_urls = await Promise.all((category?.products || []).map(async (product) => (
            fetch(`${process.env.NEXT_PUBLIC_R2_ASSETS}/${product.image_file}`)
        )));
        const imageBuffers = await Promise.all(image_urls.map(async (image_response) => {
            return image_response.arrayBuffer();
        }));

        const images = image_urls.map((image, index) => {
            const buffer = Buffer.from(imageBuffers[index]);
            return { buffer, contentType: image.headers.get('content-type') || 'image/png' }
        })
        
        const categoryProducts = images.map((image, index) => {
            const base64Image = image.buffer.toString('base64');
            const contentType = image.contentType;
            const imageSrc = `data:${contentType};base64,${base64Image}`;
            console.log("IMAGE SRC (first 100 chars):", imageSrc.substring(0, 100));
            return {
              imageSrc,
              ...((category?.products || [])?.[index] || {})
            }
        });
        const newData = {
            data: {
                ...data,
                category: {
                    ...category,
                    products: categoryProducts,
                }
            }, slug
        };
        return {
            props: newData,
        };
    } catch (error) {
        console.error("Error fetching comparison:", error);
        return { props: { data: {} } };
    }
}
