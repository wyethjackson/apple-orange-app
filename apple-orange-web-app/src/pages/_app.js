// pages/_app.jsx
import '@/styles/globals.css';
import Navbar from '@/components/Navbar';

export default function App({ Component, pageProps }) {
  return (
    <>
      <Navbar />
      <main className="container mx-auto px-4 py-6">
        <Component {...pageProps} />
      </main>
    </>
  );
}
