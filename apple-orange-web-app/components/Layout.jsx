// components/Layout.jsx
import Navbar from './Navbar';
import CategoryNav from './CategoryNav';
import Head from 'next/head';
import Link from 'next/link';

export default function Layout(props) {
  const { allCategories, children } = props;
    return (
    <div className="bg-orange-50 min-h-screen">
        <Head>
          <title>{props?.category?.title || "Apple Orange"}</title>
          <meta name="description" content={props?.category?.overview || "Find the best product for your needs through curated, comparison-based reviews."} />
          <meta name="robots" content="index, follow" />
          <link rel="canonical" href={`https://www.appleorange.com`} />
          {(props?.category?.products || props?.leafCategoryProducts || []).map((product) => (
            <script
              key={product.slug}
              type="application/ld+json"
              dangerouslySetInnerHTML={{
                __html: JSON.stringify({
                  // "@context": "https://schema.org",
                  "@type": "Product",
                  "name": product.name,
                  "image": `https://www.appleorange.com/products/${product.image_file}`,
                  "description": product.description,
                  "brand": {
                    "@type": "Brand",
                    "name": "Various"
                  },
                  "offers": {
                    "@type": "Offer",
                    "priceCurrency": "USD",
                    "price": product.price,
                    // "availability": "https://schema.org/InStock",
                    "url": `https://www.appleorange.com/categories/${product?.slug || props?.category?.slug || ''}`
                  }
                }),
              }}
            />
          ))}
        </Head>
      <Navbar categories={allCategories}/>
      <div className="hidden md:block">
        <CategoryNav categories={allCategories} />
      </div>
      <main className="container w-full sm:max-w-full md:max-w-3xl lg:max-w-5xl xl:max-w-6xl mx-auto px-4">
        {/* <Component {...pageProps} /> */}
        {children}
      </main>
        <footer className="bg-orange-50 border-t border-orange-200 mt-10">
          <div className="max-w-5xl mx-auto px-4 py-8 text-sm text-gray-700">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div>
                <h2 className="font-semibold text-orange-700 mb-2">Apple Orange</h2>
                <p>Your go-to source for honest, helpful product comparisons.</p>
              </div>

              <div>
                <h2 className="font-semibold text-orange-700 mb-2">Categories</h2>
                <ul className="space-y-1">
                  {
                    (allCategories || []).map((cat) => (
                      <li key={cat.slug}><Link href={`/categories/${cat.slug}`}>{cat.name}</Link></li>
                    ))
                  }
                </ul>
              </div>

              {/* <div>
                <h2 className="font-semibold text-orange-700 mb-2">Quick Links</h2>
                <ul className="space-y-1">
                  <li><Link href="/comparisons">All Comparisons</Link></li>
                  <li><Link href="/about">About Us</Link></li>
                  <li><Link href="/contact">Contact</Link></li>
                </ul>
              </div> */}
            </div>

            <p className="text-center text-xs text-gray-500 mt-6">
              © {new Date().getFullYear()} Apple Orange. All rights reserved.
            </p>
          </div>
        </footer>

    </div>
        // <div className="min-h-screen bg-orange-50">
        //     <Navbar />
        //     {/* Only display the CategoryNav on desktop */}
        //     <div className="hidden md:block">
        //         <CategoryNav categories={categories} />
        //     </div>
        //     <main className="max-w-5xl mx-auto px-4 py-6">
        //         {children}
        //     </main>
        // </div>
    );
}
