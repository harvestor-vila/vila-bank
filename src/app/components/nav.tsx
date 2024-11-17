'use client';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useCart } from '@/app/context/cart-context';

const Navigation = () => {
  const pathname = usePathname();
  const { cart } = useCart();

  const navItems = [
    { href: '/', label: 'About' },
    { href: '/matrix', label: 'Matrix View' },
    { href: '/gallery', label: 'Gallery View' },
  ];

  return (
    <nav className="border-b bg-white/75 backdrop-blur-sm sticky z-50">
      <div className="px-5">
        <div className="flex h-16 items-center">
          <div className="flex items-center">
            <Link
              key="/"
              href="/"
              className="text-cyan-600 text-xl font-semibold"
            >
              VILA Bank
            </Link>
          </div>
          <div className="ml-auto flex items-center gap-6">
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className={`relative flex items-center font-medium text-sm transition-colors text-black-500 hover:text-[#00acc1]
                  after:absolute after:bottom-0 after:left-0 after:h-[2px] after:w-full after:scale-x-0 after:bg-[#00acc1] after:transition-transform after:duration-300
                  ${pathname === item.href 
                    ? 'after:scale-x-100' 
                    : 'hover:after:scale-x-100'
                  }
                `}
              >
                {item.label}
              </Link>
            ))}
            <div className="relative">
              <Link href="/cart" className="flex items-center gap-2">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                >
                  <circle cx="9" cy="21" r="1" />
                  <circle cx="20" cy="21" r="1" />
                  <path d="M1 1h4l1.68 12.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6" />
                </svg>
                <span className="text-sm">Cart ({cart.length})</span>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navigation;
