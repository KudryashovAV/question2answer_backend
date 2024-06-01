import React, {useState} from "react";
import Navbar from "./navBar";
import {PhotoIcon} from "@heroicons/react/16/solid";
import FileProcessor from "./fileProcessor";

const Actions = () => {


  return (
    <div>
      <Navbar />
      <div className="flex flex-row gap-4 sm:gap-8 lg:gap-10">
        <FileProcessor type="questions"/>
        <FileProcessor type="users"/>
      </div>

    </div>
  );
}

export default Actions;
