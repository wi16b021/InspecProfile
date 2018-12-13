# encoding: utf-8
# copyright: 2018, CloudComputing

title 'sample tests for CloudComputing'

# sample default test
describe file('/tmp') do
  it { should be_directory }
end

# add controls here
control 'tmp-1.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Create /tmp directory'             # A human-readable title
  desc 'An optional description...'
  describe file('/tmp') do                  # The actual test
    it { should be_directory }
  end
end

control 'apache-and-azure-tests' do
  impact 'medium'
  title 'Apache2 should be configured and running'
  desc 'Checks if Apache is up and running and several tests regarding azure VMs'
  describe service(apache.service) do
    it { should be_enabled }
    it { should be_running }
  end

  describe azure_virtual_machine(group_name: 'LoadBalancer', name: 'VirtualMachine1') do
    its('VmSize') { should eq 'Standard_A0' }
    desc 'Check if the size of the VM is a Standard_A0'
  end

  describe azure_virtual_machine(group_name: 'LoadBalancer', name: 'VirtualMachine1') do
    its('type') { should cmp 'Microsoft.Compute/virtualMachines' }
    desc 'Check if the VirtualMachine1 is of type virtualMachines'
  end

  describe azure_virtual_machine(group_name: 'LoadBalancer', name: 'VirtualMachine1') do
    its('location') { should eq 'westeurope' }
    desc 'Check if the virtual machines location is in westeurope'
  end

  describe azure_virtual_machine(group_name: 'LoadBalancer', name: 'VirtualMachine1') do
    its('os_type') { should cmp 'Linux' }
    desc 'Check if the virtual machine runs on Linux'
  end
end
