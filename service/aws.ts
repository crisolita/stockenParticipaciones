import AWS from "aws-sdk";
import { Readable } from "stream";
const spacesEndpoint = new AWS.Endpoint(
  process.env.SPACEENDPOINT ? process.env.SPACEENDPOINT : ""
);
const s3 = new AWS.S3({
  accessKeyId: process.env.ACCESSKEYBUCKET,
  secretAccessKey: process.env.SECRETACCESSKEYBUCKET,
});
AWS.config.update({
  accessKeyId: process.env.ACCESSKEYBUCKET,
  secretAccessKey: process.env.SECRETACCESSKEYBUCKET,
});
// Subir una imagen
export const uploadImage = async (key: ArrayBuffer, ruta: string) => {
  const stream = new Readable();
  stream.push(Buffer.from(key));
  stream.push(null);
  const params = {
    Bucket: "blockimpulse-bucket-for-objects-uploading",
    Key: `${ruta}.jpg`,
    Body: stream,
  };
  s3.upload(params, function (err: any, data: any) {
    if (err) {
      console.error("Error al subir la imagen:", err);
    } else {
      console.log("Imagen subida:", data.Location);
    }
  });
};
export const uploadDoc = async (key: ArrayBuffer, ruta: string) => {
  const stream = new Readable();
  stream.push(Buffer.from(key));
  stream.push(null);
  const params = {
    Bucket: "blockimpulse-bucket-for-objects-uploading",
    Key: `${ruta}.pdf`,
    Body: stream,
  };
  s3.upload(params, function (err: any, data: any) {
    if (err) {
      console.error("Error al subir la imagen:", err);
    } else {
      console.log("Imagen subida:", data.Location);
    }
  });
};

// Obtener una imagen
export const getImage = async (key: string) => {
  const getObjectParams = {
    Bucket: "blockimpulse-bucket-for-objects-uploading",
    Key: `${key}.jpg`,
  };
  const imageUrl = s3.getSignedUrl("getObject", getObjectParams);
  return imageUrl;
};
export const getDoc = async (key: string) => {
  const getObjectParams = {
    Bucket: "blockimpulse-bucket-for-objects-uploading",
    Key: `${key}.pdf`,
  };
  const docUrl = s3.getSignedUrl("getObject", getObjectParams);
  return docUrl;
};
/// borrar una imagen
export const deleteMediaAWS = async (key: string) => {
  const params = {
    Bucket: "blockimpulse-bucket-for-objects-uploading",
    Key: `${key}.jpg`,
  };

  try {
    await s3.deleteObject(params).promise();
    console.log("Imagen eliminada con éxito");
  } catch (err) {
    console.error("Error al eliminar la imagen:", err);
  }
};
