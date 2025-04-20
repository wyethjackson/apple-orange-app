// components/Layout.jsx
import Navbar from './Navbar';
import CategoryNav from './CategoryNav';

export default function Layout({ categories, children }) {
    return (
    <div className="bg-orange-50 min-h-screen">
      <Navbar categories={categories}/>
      <div className="hidden md:block">
        <CategoryNav categories={categories} />
      </div>
      <main className="container w-full sm:max-w-full md:max-w-3xl lg:max-w-5xl xl:max-w-6xl mx-auto px-4 py-6">
        {/* <Component {...pageProps} /> */}
        {children}
      </main>
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
