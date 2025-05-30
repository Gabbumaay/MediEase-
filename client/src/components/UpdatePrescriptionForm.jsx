import React, { useState, useEffect } from "react";
import Select from "react-select";
import { TrashIcon, PlusCircleIcon } from "@heroicons/react/24/solid";
import {
  CardBody,
  Card,
  Input,
  CardHeader,
  Typography,
  Button,
  CardFooter,
  Select as MaterialSelect,
  Option,
  Tooltip,
  IconButton,
  Textarea,
} from "@material-tailwind/react";
import { toast } from "sonner";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";
import { apiRoutes } from "../utils/apiRoutes";
import { useAuthContext } from "../hooks/useAuthContext";
import { SyncLoadingScreen } from "./UI/LoadingScreen";
import Layout from "../layouts/PageLayout";

export default function UpdatePrescriptionForm() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const { userEmail } = useAuthContext();
  const [formData, setFormData] = useState({
    email: "",
    doctor: "",
    date: "",
    temperature: "",
    bloodPressure: "",
    name: "",
    pulseRate: "",
    spO2: "",
    symptoms: "",
    diagnosis: "",
  });

  const [doctors, setDoctors] = useState([]);
  const [selectedDoctor, setSelectedDoctor] = useState("");
  const [patients, setPatients] = useState([]);
  const [selectedPatient, setSelectedPatient] = useState("");
  const TABLE_HEAD = [
    "Medicine Name",
    "Dosage",
    "Quantity",
    "Avl. Qty",
    "Action",
  ];
  const [dataArray, setDataArray] = useState([
    { name: "", dosage: "", quantity: "" },
  ]);

  const [medicines, setMedicines] = useState([]);
  const [selectedMedicine, setSelectedMedicine] = useState("");

  useEffect(
    () => async () => {
      // Fetch doctors list when the component mounts
      // fetchDoctors();
      setLoading(true);
      await fetchUpdatedAvailableStock();
      await fetchDoctors();
      await fetchPatients();
     await fetchPrescriptionData();
      setLoading(false);
    },
    []
  );
  const fetchPrescriptionData = async () => {
    try {
        const response = await axios.get(`${apiRoutes.checkup}/${id}`, {
            withCredentials: true,
        });
        console.log(response.data.data);
        const prescriptionData = response.data.data;
        setFormData({
            email: prescriptionData.ppatientEmail,
            doctor: prescriptionData.doctorEmail,
            date: prescriptionData.date,
            temperature: prescriptionData.temperature,
            bloodPressure: prescriptionData.bloodPressure,
            pulseRate: prescriptionData.pulseRate,
            spO2: prescriptionData.spO2,
            symptoms: prescriptionData.symptoms,
            diagnosis: prescriptionData.diagnosis,
            referredDoctor: prescriptionData.referredDoctor,
            referredHospital: prescriptionData.referredHospital,
        });
        setSelectedDoctor({
            value: prescriptionData.doctorId,
            label: prescriptionData.doctorEmail,
        });
        setSelectedPatient({
            value: prescriptionData.patientId,
            label: prescriptionData.patientEmail,
            name: prescriptionData.patientName,
        });
        const checkupMedicines = prescriptionData.checkupMedicines.map(
            (medicine, idx) => {
                return {
                    name: {
                        value: medicine.id,
                        label: medicine.brandName,
                        netQuantity: medicines.find((ele)=>ele.medicineId === medicine.medicineId)?.netQuantity,    //highly inefficient
                    },
                    dosage: medicine.dosage,
                    quantity: medicine.quantity,
                };
            }
        );
        // console.log(medicines);
        // console.log(checkupMedicines);
        setDataArray(checkupMedicines);
    } catch (error) {
        console.error(
            `ERROR (fetch-prescription-in-update-prescription): ${error?.response?.data?.message}`
        );
        toast.error(
            error?.response?.data?.message || "Failed to fetch Prescription Data"
        );
    }
    };

  const fetchDoctors = async () => {
    try {
      const response = await axios.get(apiRoutes.staff, {
        withCredentials: true,
      });
      response.data.data = response.data.data.filter(
        (staff) => staff.role === "DOCTOR"
      );
      const doctorList = response.data.data;
      setDoctors(doctorList);
    } catch (error) {
      console.error(
        `ERROR (fetch-doctors-in-add-prescription): ${error?.response?.data?.message}`
      );
      toast.error(
        error?.response?.data?.message || "Failed to fetch Doctors List"
      );
    }
  };
  const fetchPatients = async () => {
    try {
      const response = await axios.get(apiRoutes.patient, {
        withCredentials: true,
      });
      setPatients(response.data.data);
    } catch (error) {
      console.error(
        `ERROR (fetch-patients-in-add-prescription): ${error?.response?.data?.message}`
      );
      toast.error(
        error?.response?.data?.message || "Failed to fetch Patients List"
      );
    }
  };

  const fetchUpdatedAvailableStock = async () => {
    try {
      const response = await axios.get(`${apiRoutes.stock}/available/${id}` , {
        withCredentials: true,
      });
      console.log(response.data.data);
      setMedicines(response.data.data); // Assuming the response is an array of medicines
    } catch (error) {
      console.error(
        `ERROR (fetch-medicines-in-add-purchase): ${error?.response?.data?.message}`
      );
      toast.error(
        error?.response?.data?.message || "Failed to fetch Medicines"
      );
    }
  };

  const handleInputChange = (key, index, value) => {
    // console.log(dataArray)
    console.log(key, index, value);
    const updatedArray = [...dataArray];
    console.log(updatedArray);
    updatedArray[index][key] = value;
    setDataArray(updatedArray);
  };

  const handleDoctorChange = (selectedDoctor) => {
    console.log(selectedDoctor);
    setSelectedDoctor(selectedDoctor);
    setFormData((prevData) => ({
      ...prevData,
      doctor: selectedDoctor.value,
    }));
  };
  const handlePatientChange = (selectedPatient) => {
    console.log('handle patient change')
    console.log(selectedPatient);
    setSelectedPatient(selectedPatient);
    setFormData((prevData) => ({
      ...prevData,
      email: selectedPatient.label,
    }));
  };
  const handleMedicineChange = (selectedMedicine, index) => {
    console.log(selectedMedicine);
    setSelectedMedicine(selectedMedicine);
    setDataArray((prevData) => {
      const updatedArray = [...prevData];
      updatedArray[index].name = selectedMedicine;
      console.log(updatedArray);
      return updatedArray;
    });
  };

  const handleChange = (name, value) => {
    // console.log(e.target);
    // const { name, value } = e.target;
    console.log(name, value);
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    // Here you can handle the submission of the form
    const checkupListEntry = {
      patientId: selectedPatient?.value,
      date: formData.date,
      diagnosis: formData.diagnosis,
    };
    //optional fields
    if (selectedDoctor?.value) {
      checkupListEntry.doctorId = selectedDoctor?.value;
    }
    if (formData.temperature) {
      checkupListEntry.temperature = formData.temperature;
    }
    if (formData.pulseRate) {
      checkupListEntry.pulseRate = formData.pulseRate;
    }
    if (formData.spO2) {
      checkupListEntry.spO2 = formData.spO2;
    }
    if (formData.bloodPressure) {
      checkupListEntry.bloodPressure = formData.bloodPressure;
    }
    if (formData.symptoms) {
      checkupListEntry.symptoms = formData.symptoms;
    }
    if(formData.referredDoctor){
      checkupListEntry.referredDoctor = formData.referredDoctor;
    }
    if(formData.referredHospital){
      checkupListEntry.referredHospital = formData.referredHospital;
    }


    const checkupMedicines = dataArray.map((data) => {
      const medicines = {
        medicineId: data?.name?.value,
        quantity: parseInt(data.quantity) || 0,
      };
      if (data.dosage) medicines.dosage = data.dosage;
      return medicines;
    });

    const data = {
      ...checkupListEntry,
      staffEmail: userEmail,
      checkupMedicines,
    };
    console.log(data);
    setLoading(true);
    try {
      const response = await axios.put(`${apiRoutes.checkup}/${id}`, data, {
        withCredentials: true,
      });
      console.log(response.data);
      toast.success(response.data.message);
      setTimeout(() => {
        navigate("/prescription");
      }, 1000);
    } catch (error) {
      console.error(
        `ERROR (update-prescription): ${error?.response?.data?.message}`
      );
      toast.error(
        error?.response?.data?.message || "Failed to update Prescription"
      );
    }
    setLoading(false);
  };

  const handleAddRow = () => {
    setDataArray((prevData) => [
      ...prevData,
      { name: "", dosage: "", quantity: "" },
    ]);
  };

  const handleDeleteRow = (index) => {
    // *****condition for allowing no. of medicines considerint referal given
    if (formData.referredDoctor === "" && formData.referredHospital === "" && dataArray.length === 1) {
      toast.error("Atleast one Medicine is required in the prescription");
      return;  
    }
    setDataArray((prev) => {
      const newData = [...prev];
      newData.splice(index, 1);
      return newData;
    });
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
                <Typography variant="h5" color="blue-gray">
                  Edit Prescription Details
                </Typography>
              </div>
              <div className="flex shrink-0 flex-col gap-2 sm:flex-row">
                <Button
                  className="flex items-center gap-3"
                  size="md"
                  onClick={() => {
                    navigate("/prescription");
                  }}
                >
                  Prescription List
                </Button>
              </div>
            </div>
          </CardHeader>
          <CardBody>
            <form onSubmit={handleSubmit} className="flex flex-wrap gap-6">
              <div className="grid md:grid-cols-2 gap-y-8 gap-x-4 w-full">
                <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                  <div className="flex mr-4 w-full md:w-72 justify-end">
                    <label htmlFor="email">
                      Patient Email <span className="text-red-800">*</span>:
                    </label>
                  </div>
                  <Select
                    id="email"
                    options={patients.map((patient) => ({
                      value: patient.id,
                      label: patient.email,
                      name: patient.name,
                    }))}
                    name="email"
                    placeholder="Select Patient"
                    className="w-full"
                    value={selectedPatient}
                    onChange={handlePatientChange}
                    isClearable={true}
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end ">
                    <label htmlFor="name">
                      Patient Name <span className="text-red-800">*</span>:
                    </label>
                  </div>
                  <Input
                    id="name"
                    size="md"
                    name="name"
                    label=""
                    className="w-full"
                    value={selectedPatient?.name|| ""}
                    disabled
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="temperature">Temp.(C)</label>:
                  </div>
                  <Input
                    id="temperature"
                    size="md"
                    name="temperature"
                    label="Temperature"
                    className="w-full"
                    value={formData.temperature}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="pulseRate">PR(beats/min)</label>:
                  </div>
                  <Input
                    id="pulseRate"
                    type="number"
                    min={1}
                    size="md"
                    name="pulseRate"
                    label="Pulse Rate"
                    className="w-full"
                    value={formData.pulseRate}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="pulseRate">SpO2 (%)</label>:
                  </div>
                  <Input
                    id="spO2"
                    size="md"
                    name="spO2"
                    label="SpO2"
                    className="w-full"
                    value={formData.spO2}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="bloodPressure">BP(mm Hg)</label>:
                  </div>
                  <Input
                    id="bloodPressure"
                    size="md"
                    name="bloodPressure"
                    label="Blood pressure"
                    className="w-full"
                    value={formData.bloodPressure}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="date">
                      Date<span className="text-red-800">*</span>:
                    </label>
                  </div>
                  <Input
                    id="date"
                    size="md"
                    label="Date"
                    name="date"
                    type="date"
                    className="w-full border-blue-gray-200 border h-10 px-3 rounded-lg min-w-[200px]"
                    value={formData.date}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="doctor">Doctor:</label>
                  </div>
                  <Select
                    id="doctor"
                    options={doctors.map((doctor) => ({
                      value: doctor.id,
                      label: doctor.email,
                    }))}
                    name="doctor"
                    placeholder="Select Doctor"
                    className="w-full"
                    value={selectedDoctor}
                    onChange={handleDoctorChange}
                    isClearable={true}
                  />
                </div>

                <div className="flex-col md:flex md:flex-row items-start justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="date">
                      Diagnosis<span className="text-red-800">*</span>:
                    </label>
                  </div>
                  <Textarea
                    id="diagnosis"
                    size="md"
                    label="Diagnosis"
                    name="diagnosis"
                    type="text"
                    className="w-full border-blue-gray-200 border h-10 px-3 rounded-lg min-w-[200px]"
                    value={formData.diagnosis}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>

                <div className="flex-col md:flex md:flex-row items-start justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="date">Symptoms:</label>
                  </div>
                  <Textarea
                    id="symptoms"
                    size="md"
                    label="Symptoms"
                    name="symptoms"
                    type="text"
                    className="w-full border-blue-gray-200 border h-10 px-3 rounded-lg min-w-[200px]"
                    value={formData.symptoms}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-start justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="date">Referred Doctor:</label>
                  </div>
                  <Textarea
                    id="referredDoctor"
                    size="md"
                    label="Referred Doctor"
                    name="referredDoctor"
                    type="text"
                    className="w-full border-blue-gray-200 border h-10 px-3 rounded-lg min-w-[200px]"
                    value={formData.referredDoctor}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>
                <div className="flex-col md:flex md:flex-row items-start justify-around p-1">
                  <div className="flex mr-2 w-full md:w-72 justify-end">
                    <label htmlFor="date">Referred Hospital:</label>
                  </div>
                  <Textarea
                    id="referredHospital"
                    size="md"
                    label="Referred Hospital"
                    name="referredHospital"
                    type="text"
                    className="w-full border-blue-gray-200 border h-10 px-3 rounded-lg min-w-[200px]"
                    value={formData.referredHospital}
                    onChange={(e) =>
                      handleChange(e.target.name, e.target.value)
                    }
                  />
                </div>
              </div>

              <div className="w-full ">
                <table className="w-full min-w-max table-auto text-left">
                  <thead>
                    <tr>
                      {TABLE_HEAD.map((head) => (
                        <th
                          key={head}
                          className="border-b border-blue-gray-100 bg-blue-gray-50 p-4"
                        >
                          <Typography
                            variant="small"
                            color="blue-gray"
                            className="font-normal leading-none opacity-70"
                          >
                            {head}
                            {head !== "Dosage" && head !== "Action" && (
                              <span className="text-red-800">*</span>
                            )}
                          </Typography>
                        </th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {dataArray.map((data, index) => (
                      <tr className="even:bg-blue-gray">
                        <td className="p-4">
                          <Select
                            id="medicine"
                            options={medicines.map((stock) => ({
                              value: stock.medicineId,
                              netQuantity: stock.netQuantity,
                              label: stock.medicineName,
                            }))}
                            value={data["name"]}
                            onChange={(selectedMedicine) =>
                              handleMedicineChange(selectedMedicine, index)
                            }
                            isClearable={true}
                            placeholder="Select Medicine"
                            className="w-full"
                          />
                        </td>
                        <td className="p-4">
                          <input
                            type="text"
                            className="w-full border-blue-gray-200 border h-10 px-3 rounded-lg min-w-[200px]"
                            placeholder="Dosage"
                            value={data["dosage"]}
                            onChange={(e) =>
                              handleInputChange("dosage", index, e.target.value)
                            }
                          />
                        </td>
                        <td className="p-4">
                          <div className="flex-col md:flex md:flex-row items-center justify-around p-1">
                            <input
                              type="number"
                              min={1}
                              className="w-full border-blue-gray-200 border h-10 px-3 rounded-lg min-w-[200px]"
                              placeholder="Quantity"
                              value={data["quantity"]}
                              onChange={(e) =>
                                handleInputChange(
                                  "quantity",
                                  index,
                                  e.target.value
                                )
                              }
                            />
                          </div>
                        </td>
                        <td className="p-4">
                          <div className="flex-col md:flex md:flex-row items-center justify-start p-1 min-w-[200px]">
                            <Input
                              type="number"
                              min={1}
                              value={data["name"]?.netQuantity || ""}
                              disabled
                            />
                          </div>
                        </td>
                        <td className="p-4">
                          <Tooltip content="Delete">
                            <IconButton
                              variant="text"
                              onClick={() => handleDeleteRow(index)}
                            >
                              <TrashIcon className="h-4 w-4" />
                            </IconButton>
                          </Tooltip>
                        </td>
                      </tr>
                    ))}
                    <tr>
                      <td colSpan="4" className="p-4">
                        <div className="flex justify-center items-center gap-2">
                          <Tooltip content="Add">
                            <IconButton variant="text" onClick={handleAddRow}>
                              <PlusCircleIcon className="h-5 w-5" />
                            </IconButton>
                          </Tooltip>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
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
