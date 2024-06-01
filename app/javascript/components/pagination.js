import React from "react";

const Pagination = ({
  pageNumber,
  isNext,
  total_pages,
  total_records,
  records_type,
  pageHandler
  }) =>  {

  const handlePagination = (direction) => {
    return direction === "prev" ? pageHandler(pageNumber - 1) : pageHandler(pageNumber + 1);
  };

  if (!isNext && pageNumber === 1) return null;

  return (
    <div className="mt-10 flex items-center justify-center gap-2">
      <button
        type="button"
        disabled={pageNumber === 1}
        onClick={() => handlePagination("prev")}
        className="rounded-full disabled:bg-orange-300 bg-orange-500 px-3 py-1.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-orange-400"
      >
        Prev
      </button>
      <div className="rounded-full bg-orange-400 px-2.5 py-1 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-orange-400">
        <p>
          Page {pageNumber} from {total_pages} - 12 from {total_records}{" "}{records_type}
        </p>
      </div>
      <button
        type="button"
        disabled={pageNumber >= total_pages}
        onClick={() => handlePagination("next")}
        className="rounded-full disabled:bg-orange-300 bg-orange-500 px-3 py-1.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-orange-400"
      >
        Next
      </button>
    </div>
  );
}

export default Pagination
