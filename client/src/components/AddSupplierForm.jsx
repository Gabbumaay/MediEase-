import React, { useState,useEffect } from "react";
import {
  CardBody,
  Input,
  Card,
  CardHeader,
  Typography,
  Button,
  CardFooter,
  Select,
  Option,
} from "@material-tailwind/react";
import { toast } from "sonner";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import { apiRoutes } from "../utils/apiRoutes";
import Layout from "../layouts/PageLayout";
import { SyncLoadingScreen } from "./UI/LoadingScreen";

export default function AddSupplierForm() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    supplierName: "",
    mobileNo: "",
    email: "",
    city: "",
    state: "",
    zip: "",
    address1: "",
    address2: "",
  });

  useEffect(
    ()=>{
      const form_data = sessionStorage.getItem(ADD_SUPPLIER)
      console.log(form_data)
      if(form_data){
        setFormData(JSON.parse(form_data))
      }
    },
    []
  );

  const ADD_SUPPLIER = "addSuplier"



  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => {
      const updatedForm = {
        ...prevData,
        [name]: value,
      }
      sessionStorage.setItem(ADD_SUPPLIER,JSON.stringify(updatedForm));
      return updatedForm
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const data = {
      name: formData.supplierName,
      mobileNumber: formData.mobileNo,
      state: formData.state,
      address1: formData.address1,
    };
    if (formData.email) data.email = formData.email;
    if (formData.city) data.city = formData.city;
    if (formData.zip) data.pinCode = parseInt(formData.zip) || 0;
    if (formData.address2) data.address2 = formData.address2;
    // Here you can handle the submission of the form
    console.log(data);
    setLoading(true);
    try {
      const response = await axios.post(apiRoutes.supplier, data, {
        withCredentials: true,
      });
      console.log(response);
      toast.success("Supplier added successfully");
      sessionStorage.removeItem(ADD_SUPPLIER);
      setTimeout(() => {
        navigate("/supplier");
      }, 100);
    } catch (error) {
      console.error(`ERROR (add-supplier): ${error?.response?.data?.message}`);
      toast.error(error?.response?.data?.message || "Failed to add Supplier");
    }
    setLoading(false);
  };

  return (
    <>
      {loading && <SyncLoadingScreen />}
      {!loading && (
        <Layout>
          <Card className="h-max w-full">
            <CardHeader
              floated={false}
              shadow={false}
              className="rounded-none pb-3"
            >
              <div className="mb-2 sm:flex sm:flex-row flex-col items-center justify-between gap-8">
                <div>
                  <div className="flex flex-row items-center justify-between gap-8">
                    <Typography variant="h5" color="blue-gray">
                      Supplier Form
                    </Typography>
                    <div className="flex shrink-0 flex-col gap-2 sm:flex-row sm:hidden">
                      <Button
                        className="flex items-center gap-3"
                        size="md"
                        onClick={() => {
                          navigate("/supplier");
                        }}
                      >
                        Supplier List
                      </Button>
                    </div>
                  </div>
                  <Typography color="gray" className="mt-1 font-normal">
                    Add a new supplier to the list.
                  </Typography>
                </div>
                <div className="hidden sm:flex shrink-0 flex-col gap-2 sm:flex-row">
                  <Button
                    className="flex items-center gap-3"
                    size="md"
                    onClick={() => {
                      navigate("/supplier");
                    }}
                  >
                    Supplier List
                  </Button>
                </div>
              </div>
            </CardHeader>
            <CardBody className="p-3 sm:p-6">
              <form onSubmit={handleSubmit} className="flex flex-wrap gap-6">
                <div className="grid  sm:grid-cols-2 gap-y-8 gap-x-4 w-full">
                  <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                    <div className="flex mr-4 md:w-72 w-full justify-end">
                      <label htmlFor="supplierName">
                        Supplier Name <span className="text-red-800">*</span>:
                      </label>
                    </div>
                    <Input
                      id="supplierName"
                      size="md"
                      label="Supplier Name"
                      className="w-full"
                      name="supplierName"
                      value={formData.supplierName}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                    <div className="flex mr-2 md:w-72 w-full justify-end">
                      <label htmlFor="mobileNo">
                        Mobile No <span className="text-red-800">*</span>:
                      </label>
                    </div>
                    <Input
                      id="mobileNo"
                      size="md"
                      label="Mobile No"
                      name="mobileNo"
                      value={formData.mobileNo}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                    <div className="flex mr-2 md:w-72 w-full justify-end">
                      <label htmlFor="email">Email :</label>
                    </div>
                    <Input
                      id="email"
                      size="md"
                      label="Email"
                      name="email"
                      value={formData.email}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                    <div className="flex mr-2 md:w-72 w-full justify-end">
                      <label htmlFor="city">City :</label>
                    </div>
                    <Input
                      id="city"
                      size="md"
                      label="City"
                      name="city"
                      value={formData.city}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                    <div className="flex mr-2 md:w-72 w-full justify-end">
                      <label htmlFor="state">
                        State <span className="text-red-800">*</span>:
                      </label>
                    </div>
                    <Input
                      id="state"
                      size="md"
                      label="State"
                      name="state"
                      value={formData.state}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                    <div className="flex mr-2 md:w-72 w-full justify-end">
                      <label htmlFor="zip">ZIP:</label>
                    </div>
                    <Input
                      id="zip"
                      type="number"
                      min={1}
                      size="md"
                      label="ZIP"
                      name="zip"
                      value={formData.zip}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                    <div className="flex mr-2 md:w-72 w-full justify-end">
                      <label htmlFor="address1">
                        Address Line 1 <span className="text-red-800">*</span>:
                      </label>
                    </div>
                    <Input
                      id="address1"
                      size="md"
                      label="Address Line 1"
                      name="address1"
                      value={formData.address1}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                    <div className="flex mr-2 md:w-72 w-full justify-end">
                      <label htmlFor="address2">Address Line 2:</label>
                    </div>
                    <Input
                      id="address2"
                      size="md"
                      label="Address Line 2"
                      name="address2"
                      value={formData.address2}
                      onChange={handleChange}
                    />
                  </div>
                </div>
              </form>
            </CardBody>
            <CardFooter divider={true}>
              <div className="flex justify-end">
                <Button
                  className="flex items-center gap-3"
                  size="lg"
                  onClick={handleSubmit}
                >
                  Save
                </Button>
              </div>
            </CardFooter>
          </Card>
        </Layout>
      )}
    </>
  );
}
