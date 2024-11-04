import Image from "next/image";
import BlueMatrix from "./components/BlueMatrix";

export default function Home() {
  return (
    <div className="w-full overflow-auto">
      <BlueMatrix />
    </div>
  );
}
