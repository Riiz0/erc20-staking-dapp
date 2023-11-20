import Image from 'next/image'
import React from 'react'
import Link from 'next/link';

export default function Home() {
  return (
    <div className="relative min-h-screen">
      {/* Navbar */}
      <nav className="bg-white w-full fixed top-0 left-0 p-4 flex items-center justify-between border-b border-gray-300">
        <div className="flex items-center">
          <Image
            src="/logo.svg" // Replace with your logo image path
            alt="Logo"
            width={32}
            height={32}
          />
        </div>
        <div className="flex space-x-4">
          <Link href="/" className="text-black hover:text-blue-500">Stake</Link>
          <Link href="/more" className="text-black hover:text-blue-500">More</Link>
        </div>
        <button className="bg-black text-white px-4 py-2 rounded">
          DApp
        </button>
      </nav>

    {/* Main Content */}
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
    <div className="relative z-10 max-w-5xl w-full items-center justify-between font-mono text-sm lg:flex">
  <div className="fixed bottom-0 left-0 flex h-48 w-full items-end justify-center bg-gradient-to-t from-white via-white dark:from-black dark:via-black lg:static lg:h-auto lg:w-auto lg:bg-none">
    <a
      className="pointer-events-none flex place-items-center gap-2 p-8 lg:pointer-events-auto lg:p-0"
      href="https://vercel.com?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"

      
target="_blank"

      
rel="noopener noreferrer"
    >
    </a>
  </div>

  {/* Transparent container for staking pool information */}
  <div className="absolute top-20 left-0 w-full h-full bg-transparent">
  <div className="container mx-auto max-w-7xl px-4">
    <h2 className="text-3xl font-bold text-center">Staking Pool Information</h2>
    <p className="text-lg text-center">This is the staking pool information.</p>
  </div>
  </div>
</div>

      <div className="relative flex place-items-center before:absolute before:h-[300px] before:w-[480px] before:-translate-x-1/2 before:rounded-full before:bg-gradient-radial before:from-white before:to-transparent before:blur-2xl before:content-[''] after:absolute after:-z-20 after:h-[180px] after:w-[240px] after:translate-x-1/3 after:bg-gradient-conic after:from-sky-200 after:via-blue-200 after:blur-2xl after:content-[''] before:dark:bg-gradient-to-br before:dark:from-transparent before:dark:to-blue-700 before:dark:opacity-10 after:dark:from-sky-900 after:dark:via-[#0141ff] after:dark:opacity-40 before:lg:h-[360px] z-[-1]">
      </div>

      <div className="mb-32 grid text-center lg:max-w-5xl lg:w-full lg:mb-0 lg:grid-cols-2 lg:text-left">
        <a
          href="https://vercel.com/templates?framework=next.js&utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"
          className="group rounded-lg border border-transparent px-5 py-4 transition-colors hover:border-gray-300 hover:bg-gray-100 hover:dark:border-neutral-700 hover:dark:bg-neutral-800/30"
          target="_blank"
          rel="noopener noreferrer"
        >
          <h2 className={`mb-3 text-2xl font-semibold text-center`}>
            Stake
            <span className="inline-block transition-transform group-hover:translate-x-1 motion-reduce:transform-none">
              -&gt;
            </span>
          </h2>
          <p className={`m-0 max-w-[50ch] text-sm opacity-50 text-center`}>
            "Text Will Be Here To Display The Amount Of APY For Each Stake"
          </p>
        </a>

        <a
          href="https://vercel.com/new?utm_source=create-next-app&utm_medium=appdir-template&utm_campaign=create-next-app"
          className="group rounded-lg border border-transparent px-5 py-4 transition-colors hover:border-gray-300 hover:bg-gray-100 hover:dark:border-neutral-700 hover:dark:bg-neutral-800/30"
          target="_blank"
          rel="noopener noreferrer"
        >
          <h2 className={`mb-3 text-2xl font-semibold text-center`}>
            Confirm
            <span className="inline-block transition-transform group-hover:translate-x-1 motion-reduce:transform-none">
              -&gt;
            </span>
          </h2>
          <p className={`m-0 max-w-[50ch] text-sm opacity-50 text-center`}>
          "Text Will Be Here To Display The Confirm Button For Each Stake"
          </p>
        </a>
      </div>
    </main>

    <footer className="bg-white w-full fixed bottom-0 left-0 p-4 flex items-center justify-center border-t border-gray-300">
      <p className="text-center text-black">Staking Project Created For Your Eyes Only</p>
    </footer>
  </div>
  )
}
