// pages/index.jsx
import BlogCard from '../components/BlogCard';
import ProductCard from '../components/ProductCard';
import {Title} from '../components/Typography'
import React from 'react';
import Layout from '@/components/Layout';
import FeaturedProductCard from '@/components/FeaturedProductCard';
import HeroImage from '@/components/HeroImage';
import testCategoryWithChildData from '@/utils/test_category_with_child_data.json';
import fetch from 'node-fetch';

export default function Home(props) {
    const { leafCategoryProducts, allCategories, heroImageSrc} = props;
    return (
        <Layout {...props}>
            <HeroImage imageSrc={heroImageSrc} />
        <div className="max-w-6xl mx-auto px-4 py-6">
            
            
            <div className="mb-10 text-center">
                <h1 className="text-4xl font-bold text-orange-700 mb-2">Your Guide to Better Buying</h1>
                <p className="text-lg text-gray-600">
                    Browse curated product comparisons across electronics, kitchen tools, and more.
                </p>
            </div>

            {/* <div className="grid sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6"> */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    {(leafCategoryProducts || []).map((leafProduct) => (
                    <FeaturedProductCard
                        featuredProduct={leafProduct}
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
            return { props: { } };
        }

        const data = await res.json();

        let { leafCategoryProducts, allCategories, heroImage} = data;
        const imageRes = await fetch(`${process.env.NEXT_PUBLIC_R2_ASSETS}/${heroImage}`);
        const image_urls = await Promise.all((leafCategoryProducts || []).map(async (product) => {
            return fetch(`${process.env.NEXT_PUBLIC_R2_ASSETS}/${product.image_file}`)
    }));
        const imageBuffer = await imageRes.arrayBuffer();
        const heroImageData = { buffer: Buffer.from(imageBuffer), contentType: imageRes.headers.get('content-type') || 'image/png'}
        const imageBuffers = await Promise.all(image_urls.map(async (image_response) => {
            return image_response.arrayBuffer();
        }));

        const images = image_urls.map((image, index) => {
            const buffer = Buffer.from(imageBuffers[index]);
            return { buffer, contentType: image.headers.get('content-type') || 'image/png' }
        })
        
        leafCategoryProducts = images.map((image, index) => {
            const base64Image = image.buffer.toString('base64');
            const contentType = image.contentType;
            const imageSrc = `data:${contentType};base64,${base64Image}`;
            return {
                ...(leafCategoryProducts[index] || {}),
                imageSrc,
            }
        });
        return {
            props: {
                leafCategoryProducts,
                allCategories,
                heroImageSrc: `data: ${heroImageData.contentType};base64,${heroImageData.buffer.toString('base64')}`
            },
        };
    } catch (error) {
        console.error("Error fetching comparison:", error);
        return { props: { } };
    }
}
