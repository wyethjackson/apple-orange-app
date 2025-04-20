// pages/comparisons/[slug].jsx
import React from 'react';
import Image from 'next/image';
import Layout from '@/components/Layout';
import LeafCategory from '@/components/LeafCategory';
import testCategoryData from '@/utils/test_category_data.json';
import testCategoryWithChildData from '@/utils/test_category_with_child_data.json';
import fetch from 'node-fetch';
import Category from '@/components/Category';

export default function CategoryDetails({ data, slug }) {
    const { category, allCategories } = data;
    if (!category) {
        return (
            <Layout categories={allCategories}>
              <div className="container mx-auto p-4">
                <h1 className="text-3xl font-semibold mb-4">Category Not Found</h1>
                <p>No category available for "{slug}".</p>
              </div>
            </Layout>
        );
    }

    return (
        <Layout categories={allCategories}>
            {
                category.is_leaf ? (
                    <LeafCategory category={category} />
                ) : (
                    <Category category={category} />
                )
            }
            
        </Layout>
    );
}

export async function getServerSideProps(context) {
    const { slug } = context.params;
    // return {
    //     props: { 
    //         data: {
    //             slug, 
    //         category: {
    //             title: "Apple Airpods Max",
    //             overview: "When considering premium wireless headphones, it`s essential to evaluate products based on their standalone performance across critical attributes like sound quality, comfort, battery life, design, and noise cancellation. Here`s an in-depth comparison of the Apple AirPods Max alongside four prominent competitors:",
    //             conclusion: "The Apple AirPods Max cater well to those seeking premium quality audio and materials. Sony WH-1000XM5 are ideal for noise cancellation enthusiasts. Bose QuietComfort Ultra headphones provide unmatched comfort and are perfect for travelers. Sennheiser Momentum 4 Wireless are optimal for users prioritizing long battery life and balanced audio, while Bowers & Wilkins PX7 S2 are excellent for audiophiles who appreciate a warm, refined sound combined with luxurious design.",
    //             products: [
    //                 {
    //                     name: "Apple Airpods", 
    //                     subtitle: "Best Overall", 
    //                     description: "These headphones are top of the line and easily the best value for your dollar.",
    //                     price: 399.00,
    //                     image_file: "Apple_Airpods_Max.png",
    //                     pro_text:  "Exceptional audio quality, premium materials, effective ANC and transparency mode.",
    //                     con_text: "Heavy design, average battery life, premium price.",
    //                     link: "https://www.google.com"} 
    //                 ]
    //             }
    //         },
    //     }
    // }

    try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_BASE_URL}/api/categories/${slug}`);

        if (!res.ok) {
            return { props: { data: null, slug } };
        }

        const data = await res.json();
        // const data = testCategoryData;
        // const data = testCategoryWithChildData;

        const {category} = data;
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
        return { props: { data: {}, slug } };
    }
}