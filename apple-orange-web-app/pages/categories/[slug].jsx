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
    console.log(data);
    const { category } = data;
    if (!category) {
        return (
            <Layout {...data}>
              <div className="container mx-auto p-4">
                <h1 className="text-3xl font-semibold mb-4">Category Not Found</h1>
                <p>No category available for "{slug}".</p>
              </div>
            </Layout>
        );
    }

    return (
        <Layout {...data}>
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
                return {
                    redirect: {
                        destination: '/',
                        permanent: false,
                    },
                };
        }

        const data = await res.json();
        if (!data || !data.category) {
            return {
                redirect: {
                    destination: '/',
                    permanent: false,
                },
            };
        }

        const {category} = data;
        const image_urls = await Promise.all((category?.products || category?.leafCategoryProducts || []).map(async (product) => {
            console.log(`${process.env.NEXT_PUBLIC_R2_ASSETS}/${product.image_file}`);
            return fetch(`${process.env.NEXT_PUBLIC_R2_ASSETS}/${product.image_file}`)
    }));
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
            return {
              imageSrc,
                ...((category?.products || category?.leafCategoryProducts ||[])?.[index] || {})
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
        return {
            redirect: {
                destination: '/',
                permanent: false,
            },
        };
    }
}