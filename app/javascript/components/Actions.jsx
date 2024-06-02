import React, {useState} from "react";
import Navbar from "./navBar";
import FileProcessor from "./fileProcessor";
import {toast, Toaster} from "sonner";

const Actions = () => {
  const [condition, setCondition] = useState("uploadUsers");

  const formSubmitter = async (event) => {
    event.preventDefault()

    const formData = new FormData();
    formData.append("type", "activity")

    await fetch(`/admin/actions`, {
      cache: "no-store",
      method: "POST",
      body: formData,
      headers: { "X-CSRF-Token": "aaa", "Contetnt-Type":"multipart/form-data" }
    })

    toast.success("Comments and answers from reserve will be added soon");
  }

  return (
    <div>
      <Navbar />
      <div className="flex flex-col gap-4 sm:gap-8 lg:gap-10">
        <div className="mt-10 flex flex-col">
          <div className="ml-5 mb-1" >Filters:</div>
          <div className="ml-5 flex flex-row max-sm:flex-col">
            <div
              className={`${condition === "uploadUsers" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("uploadUsers")}
            >
              Upload users
            </div>
            <div
              className={`${condition === "uploadQuestions" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("uploadQuestions")}
            >
              Upload questions
            </div>
            <div
              className={`${condition === "addC&A" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("addC&A")}
            >
              Add comments&answers from reserve
            </div>
          </div>
        </div>
        <div>
          {condition === "uploadQuestions" && <FileProcessor type="questions"/>}
          {condition === "uploadUsers" && <FileProcessor type="users"/>}
          {condition === "addC&A" && (
            <div className="mt-6 flex flex-col items-center justify-center gap-x-6">
              <div className="font-medium text-lg mb-10">
                Add comments and answers from reserve to questions, and add comments from reserve to answers
              </div>
              <button
                className="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                onClick={formSubmitter}
              >
                Add from reserve
              </button>
            </div>
          )}
        </div>
      </div>
      <Toaster richColors position="top-center" />
    </div>
  );
}

export default Actions;
