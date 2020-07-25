export interface Option {
  urls: string[],
  current: string
}

export function previewImage(option: Option): Promise<boolean>;