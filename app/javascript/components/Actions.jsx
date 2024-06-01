import React from "react";
import Navbar from "./navBar";
import FileProcessor from "./fileProcessor";
import { Toaster } from "sonner";

const Actions = () => {
  return (
    <div>
      <Navbar />
      <div className="flex flex-row gap-4 sm:gap-8 lg:gap-10">
        <FileProcessor type="questions"/>
        <FileProcessor type="users"/>
      </div>
      <Toaster richColors position="top-center" />
    </div>
  );
}

export default Actions;
