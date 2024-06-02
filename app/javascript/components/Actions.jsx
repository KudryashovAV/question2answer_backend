import React, {useState} from "react";
import Navbar from "./navBar";
import FileProcessor from "./fileProcessor";
import { Toaster } from "sonner";

const Actions = () => {
  const [condition, setCondition] = useState("uploadUsers");

  return (
    <div>
      <Navbar />
      <div className="flex flex-col gap-4 sm:gap-8 lg:gap-10">
        <div className="mt-10 flex flex-col">
          <div className="ml-5 mb-1" >Filters:</div>
          <div className="ml-5 flex flex-row max-sm:flex-col">
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("uploadUsers")}
            >
              Upload users
            </div>
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("uploadQuestions")}
            >
              Upload questions
            </div>
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("addC&A")}
            >
              Add comments&answers from reserve
            </div>
          </div>
        </div>
        <div>
          {condition === "uploadQuestions" && <FileProcessor type="questions"/>}
          {condition === "uploadUsers" && <FileProcessor type="users"/>}
        </div>
      </div>
      <Toaster richColors position="top-center" />
    </div>
  );
}

export default Actions;
